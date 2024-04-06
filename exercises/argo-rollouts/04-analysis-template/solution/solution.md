# Solution

Install APISIX and the ingress controller using the shell script `install-apisix.sh`.

```
$ ./install-apisix.sh
"apisix" already exists with the same configuration, skipping
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "apisix" chart repository
Update Complete. ⎈Happy Helming!⎈
NAME: apisix
LAST DEPLOYED: Wed Apr  3 12:53:23 2024
NAMESPACE: ingress-apisix
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
1. Get the application URL by running these commands:
  export NODE_PORT=$(kubectl get --namespace ingress-apisix -o jsonpath="{.spec.ports[0].nodePort}" services apisix-gateway)
  export NODE_IP=$(kubectl get nodes --namespace ingress-apisix -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT
```

Create a new application from the Argo CD UI by clicking the button _New App_. Enter the configuration data given in the instructions. Click the _Create_ button. After manually syncing the application, it should transition into the "Healthy" status.

![canary-initial-ui](./imgs/canary-initial-ui.png)

Listing all rollouts will only show a single one. The rollout defines 10 steps.

```
$ kubectl argo rollouts list rollouts
NAME            STRATEGY   STATUS        STEP   SET-WEIGHT  READY  DESIRED  UP-TO-DATE  AVAILABLE
webapp-rollout  Canary     Healthy       10/10  100         5/5    5        5           5
```

Next up, let's roll out the change of the container image. Run the following imperative command to signal to the Rollout that you want to create a new ReplicaSet that controls replicas with the container image `bmuschko/canary-app:2.0.0`.

```
$ kubectl argo rollouts set image webapp-rollout webapp=bmuschko/canary-app:2.0.0
rollout "webapp-rollout" image updated
```

The Argo Rollouts Dashboard will stop before the first weight step.

![canary-image-change-ui](./imgs/canary-image-change-ui.png)

Promoting the rollout will make revision 2 active, and route 20% of the traffic to the new revision.

```
$ kubectl argo rollouts promote webapp-rollout
rollout 'webapp-rollout' promoted
```

The analysis run will continue to execute and always return success. Over time, the rollout will automatically promote later steps. The process will pause for 1 minute between steps.

![canary-continuous-promotion-ui](./imgs/canary-continuous-promotion-ui.png)

The process will continue until the weight of 100% has been reached. Revision 1 will be ramped down.

![canary-final-ui](./imgs/canary-final-ui.png)

The analysis run has been executed in the background. You can query for it with the following command. The analysis run will stop executing new Jobs as soon as a weight of 100% has been reached for revision 2.

```
$ kubectl argo rollouts get rollout webapp-rollout
Name:            webapp-rollout
Namespace:       default
Status:          ✔ Healthy
Strategy:        Canary
  Step:          10/10
  SetWeight:     100
  ActualWeight:  100
Images:          bmuschko/canary-app:2.0.0 (stable)
Replicas:
  Desired:       5
  Current:       5
  Updated:       5
  Ready:         5
  Available:     5

NAME                                                        KIND         STATUS        AGE  INFO
⟳ webapp-rollout                                            Rollout      ✔ Healthy     21m
├──# revision:2
│  ├──⧉ webapp-rollout-9964c579d                            ReplicaSet   ✔ Healthy     19m  stable
│  │  ├──□ webapp-rollout-9964c579d-pc7bt                   Pod          ✔ Running     19m  ready:1/1
│  │  ├──□ webapp-rollout-9964c579d-c7z9l                   Pod          ✔ Running     13m  ready:1/1
│  │  ├──□ webapp-rollout-9964c579d-hkszr                   Pod          ✔ Running     13m  ready:1/1
│  │  ├──□ webapp-rollout-9964c579d-ngqpc                   Pod          ✔ Running     13m  ready:1/1
│  │  └──□ webapp-rollout-9964c579d-t754p                   Pod          ✔ Running     13m  ready:1/1
│  └──α webapp-rollout-9964c579d-2                          AnalysisRun  ✔ Successful  19m  ✔ 11
│     ├──⊞ 20c3663f-df2b-40b2-bee1-1884e7282428.success.2   Job          ✔ Successful  18m
│     ├──⊞ 20c3663f-df2b-40b2-bee1-1884e7282428.success.3   Job          ✔ Successful  17m
│     ├──⊞ 20c3663f-df2b-40b2-bee1-1884e7282428.success.4   Job          ✔ Successful  17m
│     ├──⊞ 20c3663f-df2b-40b2-bee1-1884e7282428.success.5   Job          ✔ Successful  16m
│     ├──⊞ 20c3663f-df2b-40b2-bee1-1884e7282428.success.6   Job          ✔ Successful  16m
│     ├──⊞ 20c3663f-df2b-40b2-bee1-1884e7282428.success.7   Job          ✔ Successful  15m
│     ├──⊞ 20c3663f-df2b-40b2-bee1-1884e7282428.success.8   Job          ✔ Successful  15m
│     ├──⊞ 20c3663f-df2b-40b2-bee1-1884e7282428.success.9   Job          ✔ Successful  14m
│     ├──⊞ 20c3663f-df2b-40b2-bee1-1884e7282428.success.10  Job          ✔ Successful  14m
│     └──⊞ 20c3663f-df2b-40b2-bee1-1884e7282428.success.11  Job          ✔ Successful  13m
└──# revision:1
   └──⧉ webapp-rollout-c7dfb766c                            ReplicaSet   • ScaledDown  21m
```
# Solution

Create a new application from the Argo CD UI by clicking the button _New App_. Enter the configuration data given in the instructions. Click the _Create_ button. After manually syncing the application, it should transition into the "Healthy" status.

![blue-green-initial-ui](./imgs/blue-green-initial-ui.png)

Listing all rollouts will only show a single one.

```
$ kubectl argo rollouts list rollouts
NAME           STRATEGY   STATUS        STEP  SET-WEIGHT  READY  DESIRED  UP-TO-DATE  AVAILABLE
nginx-rollout  BlueGreen  Healthy       -     -           3/3    3        3           3
```

The status of the rollout returns "Healthy".

```
$ kubectl argo rollouts status nginx-rollout
Healthy
```

The details of the rollout will only list a single revision.

```
$ kubectl argo rollouts get rollout nginx-rollout
Name:            nginx-rollout
Namespace:       default
Status:          ✔ Healthy
Strategy:        BlueGreen
Images:          nginx:1.25.3-alpine (stable, active)
Replicas:
  Desired:       3
  Current:       3
  Updated:       3
  Ready:         3
  Available:     3

NAME                                       KIND        STATUS     AGE  INFO
⟳ nginx-rollout                            Rollout     ✔ Healthy  10m
└──# revision:1
   └──⧉ nginx-rollout-69b65b7588           ReplicaSet  ✔ Healthy  10m  stable,active
      ├──□ nginx-rollout-69b65b7588-b2bjq  Pod         ✔ Running  10m  ready:1/1
      ├──□ nginx-rollout-69b65b7588-nrjjc  Pod         ✔ Running  10m  ready:1/1
      └──□ nginx-rollout-69b65b7588-sbqgv  Pod         ✔ Running  10m  ready:1/1
```

To change the image, run the imperative command to switch to the newer container image.

```
$ kubectl argo rollouts set image nginx-rollout nginx=nginx:1.25.4-alpine
rollout "nginx-rollout" image updated
```

Then, promote the rollout.

```
$ kubectl argo rollouts promote nginx-rollout
rollout 'nginx-rollout' promoted
```

You will will see that the initial revision will be ramped down while the second revision becomes active.

```
$ kubectl argo rollouts get rollout nginx-rollout

Name:            nginx-rollout
Namespace:       default
Status:          ✔ Healthy
Strategy:        BlueGreen
Images:          nginx:1.25.4-alpine (stable, active)
Replicas:
  Desired:       3
  Current:       3
  Updated:       3
  Ready:         3
  Available:     3

NAME                                      KIND        STATUS        AGE  INFO
⟳ nginx-rollout                           Rollout     ✔ Healthy     14m
├──# revision:2
│  └──⧉ nginx-rollout-5cff9d855           ReplicaSet  ✔ Healthy     92s  stable,active
│     ├──□ nginx-rollout-5cff9d855-ngs4m  Pod         ✔ Running     92s  ready:1/1
│     ├──□ nginx-rollout-5cff9d855-q7kxx  Pod         ✔ Running     92s  ready:1/1
│     └──□ nginx-rollout-5cff9d855-w65bl  Pod         ✔ Running     92s  ready:1/1
└──# revision:1
   └──⧉ nginx-rollout-69b65b7588          ReplicaSet  • ScaledDown  14m
```
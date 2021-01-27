# Yet another AMD fan controller

Doesn't really work at the moment.

(I am not responsible in case your computer bursts into flames.)

## How it works

The program calculates a linear equation such that *min-temp* corresponds to 0 PWM and *max-temp* to 255 PWM.

It will then calculate the PWM value corresponding to the current temperature and writes it to the PWM file of the GPU.

## How to

For now, the program needs to be executed this way:

```
$ /bin/su -c './yaafc [min-temp] [max-temp]' root
```
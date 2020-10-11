# Problem 1

## a)

```text
9423
```

## b)

![stack](./stack.png)

## c)

The program is static scoping, so when searching variables, it will search local variable g first. However, there isn't one, so it will try following the static link to precedure B. In scope of B, there is still no variable g, so we continue following the static link to main, which we find g here.

# Problem 2

## a)

<pre>
B.val := '(' + B<sub>1</sub>.val + O.val + B<sub>2</sub>.val + ')'
B.val := '(' + not.val + B.val + ')'
O.val := and.val
O.val := or.val
</pre>

## b)

```

```

m = 2
k = 1


def A():
    m = 7
    global k
    k = 6


def B():
    global k
    k = 3
    A()


def C():
    k = 2

    def A():
        m = 1
        global k
        k = 5
    print('#2 {}, {}'.format(m, k))
    B()
    print('#3 {}, {}'.format(m, k))


print('#1 {}, {}'.format(m, k))
C()
print('#4 {}, {}'.format(m, k))

i = 2
j = 3


def A():
    print(i)


def B(P):
    i = 3

    def C(k):
        def D():
            i = 5
            P()

        D()
        print(i, j, k)

    C(j)


B(A)
print(i, j)

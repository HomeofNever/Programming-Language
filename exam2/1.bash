I=2
J=3

function a {
    echo "${I}"
}

function b {
    I=3;
    function c {
        function d {
            I=5;
            a;
        }

        d $1;
        echo "${I} ${J} $2";
    }
    
    c $1 ${J};
}

b a
echo "${I} ${J}"
$val = []
$former = []
def enter (x)
    $val.push(x)
end

def clear
    $former = []
    $former = $val
    $val = []
end

def cancel
    $val = []
    $val += $former
end

def add
    $former = []
    $former += $val
    b = $val.pop
    a = $val.pop
    n = a.length
    a0 = a[0]
    m = a0.length
    ex = []
    result = []
    for x in 0..(n - 1)
        for y in 0..(m - 1)
            ex.push(a[x][y] + b[x][y])
        end
        result.push(ex)
        ex = []
    end
    $val.push(result)
end

def sub
    $former = []
    $former += $val
    b = $val.pop
    a = $val.pop
    n = a.length
    a0 = a[0]
    m = a0.length
    ex = []
    result = []
    for x in 0..(n - 1)
        for y in 0..(m - 1)
            ex.push(a[x][y] - b[x][y])
        end
        result.push(ex)
        ex = []
    end
    $val.push(result)
end

def mul
    $former = []
    $former += $val
    b = $val.pop
    a = $val.pop
    n = a.length
    a0 = a[0]
    m = a0.length
    b0 = b[0]
    p = b0.length
    ex = []
    result = []
    for x in 0..(n - 1)
        for y in 0..(p - 1)
            ex2 = 0
            for k in 0..(m - 1)
                ex2 += a[x][k] * b[k][y]
            end
            ex.push(ex2)
        end
        result.push(ex)
        ex = []
    end
    $val.push(result)
end

def trans
    $former = []
    $former += $val
    a = $val.pop
    n = a.length
    a0 = a[0]
    m = a0.length
    ex = []
    result = []
    for x in 0..(m - 1)
        for y in 0..(n - 1)
            ex.push(a[y][x])
        end
        result.push(ex)
        ex = []
    end
    $val.push(result)
end

def det
    $former = []
    $former += $val
    a = $val.pop
    det2(a)
end

def det2(a)
    n = a.length
    ex = []
    smalla = []
    ex2 = 0
    if n == 1
        a2 = a.pop.pop
        return a2
    end
    for x in 0..(n - 1)
        for i in 0..(n - 1)
            if i == x
            else
                for y in 1..(n -1)
                    ex.push(a[i][y])
                end
                smalla.push(ex)
                ex=[]
            end
        end
        ex2 += (-1)**(2 + x) * a[x][0] * det2(smalla)
        smalla = []
    end
    return ex2
end

def simple
    $former = []
    $former += $val
    a = $val.pop

    n = a.length #行
    a0 = a[0]
    m = a0.length #列

    t = 0
    cy = 0

    while cy <= m-1 #きれいにする列

        lcm = 1
        
        for x in 0..n-1
            if a[x][cy] != 0
                lcm *= a[x][cy]
            end
        end
        
        for x in 0..n-1
            d = a[x][cy]
            for y in 0..m-1
                if d != 0
                    a[x][y] = a[x][y]*lcm / d
                end
            end
        end
        
        for x in 0..n-1
            d = a[x][cy]
            for y in 0..m-1
                if x != t
                    if d != 0
                        a[x][y] -= a[t][y]
                    end
                end
            end
        end
        #puts(t)

        checked = t
        t = t + 1
        cy = cy + 1

        if checked == n-1
            cy = m
        elsif cy < m-1
            while a[t][cy%m] == 0
                if t < n-1
                    t = t + 1
                elsif t == n-1
                    t = checked + 1
                    if cy <= m-1
                        cy = cy + 1
                    end
                end
            end
        end
    end

    seiri = []
    ok = true

    for x in 0..n-1
        for y in 0..m-1
            if a[x][y] != 0 && ok
                seiri.push(a[x][y])
                ok = false
            end
        end

        if seiri.length == x
            seiri.push(1)
        end
        ok = true
    end

    for x in 0..n-1
        for y in 0..m-1
            if Rational(a[x][y],seiri[x]).denominator == 1
                a[x][y] = a[x][y] / seiri[x]
            else
                a[x][y] = Rational(a[x][y],seiri[x])
        
            end
        end
    end

    $val.push(a)
    
end
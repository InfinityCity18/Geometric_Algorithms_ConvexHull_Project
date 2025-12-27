eps = 10**-12

from graham import graham

def det(a, b, c):       
     return (b[0]-a[0])*(c[1]-a[1]) - (b[1]-a[1])*(c[0]-a[0])

def batched_merge_tail(seq, n):
    batches = [seq[i:i+n] for i in range(0, len(seq), n)]
    if len(batches) > 1 and len(batches[-1]) < n:
        batches[-2].extend(batches.pop())
    return batches


def chan(points, m):
    n = len(points)
    hulls = list(map(print, batched_merge_tail(points, m))) #dzielimy na n / m otoczek, aplikujemy grahama na kazda, jesli n sie nie dzieli przez m to ostatnia jest wieksza

    p1 = max(points, key=lambda p: p[0]) #najbardziej na prawo
    p0 = (p1[0] + 1.0, p1[1]) 
    #ogolnie to jest aby wybrac punkt w nieskonczonosci, ale tu jest + 1.0 w prawo, idk jak poprawic bo to moze sie popsuc przez precyzje floatow
    final_hull = []
    final_hull.append(p1)

    for j in range(m):


chan([1,2,3,4,5,6,7,8,9,10], 3)


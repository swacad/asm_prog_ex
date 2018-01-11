"""
write function that takes integer n as input and
prints all Pythagorean triples where a^2 + b^2 = c^2 < n
"""

def pythagorean_triples(n):
    for a in range(1, n):
        for b in range(1, n):
            c_squared = a**2 + b**2
            # if c_squared < n:
            for c in range(1, n):
                if c_squared == c * c:
                    print(a, b, c)


if __name__ == '__main__':
    pythagorean_triples(200)
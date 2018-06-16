def diamond(n):
    num_lines = 2 * n + 1

    first_half = num_lines // 2 + 1

    for i in range(first_half):
        star_str = num_lines * '-'
        star_str = list(star_str)

        num_stars = 2 * i + 1
        star_idx = num_lines // 2 - i
        for j in range(star_idx, star_idx + num_stars):
            star_str[j] = '*'
        print(''.join(star_str))

    for i in range(first_half - 2, -1, -1):
        star_str = num_lines * '-'
        star_str = list(star_str)

        num_stars = 2 * i + 1
        star_idx = num_lines // 2 - i
        for j in range(star_idx, star_idx + num_stars):
            star_str[j] = '*'
        print(''.join(star_str))

def diamond2(n):
    length = 2 * n + 1
    first_half = length // 2 + 1

    for i in range(first_half):
        num_stars = 2 * i + 1
        star_idx = length // 2 - i

        for j in range(length):
            if j < star_idx:
                print('-', end='')
            elif j >= star_idx:
                if j < (star_idx + num_stars):
                    print('*', end='')
            else:
                print('-', end='')

        print('')


diamond2(2)
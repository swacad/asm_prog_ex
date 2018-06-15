def diamond(n):
    num_lines = 2 * n + 1
    print('total_stars = ' + str(num_lines))

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


diamond(8)
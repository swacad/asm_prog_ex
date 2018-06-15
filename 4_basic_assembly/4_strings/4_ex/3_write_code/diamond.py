def diamond(n):
    total_stars = 2 * n + 1
    print('total_stars = ' + str(total_stars))

    first_half = total_stars // 2 + 1

    for i in range(first_half):
        star_str = total_stars * '-'
        star_str = list(star_str)

        num_stars = 2 * i + 1
        star_idx = total_stars // 2 - i
        for j in range(star_idx, star_idx + num_stars):
            star_str[j] = '*'
        print(''.join(star_str))

    for i in range(first_half - 2, -1, -1):
        star_str = total_stars * '-'
        star_str = list(star_str)

        num_stars = 2 * i + 1
        star_idx = total_stars // 2 - i
        for j in range(star_idx, star_idx + num_stars):
            star_str[j] = '*'
        print(''.join(star_str))


diamond(8)
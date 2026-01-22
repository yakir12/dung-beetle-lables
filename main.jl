using CairoMakie

const inch = 96
const mm = inch / 25.4
n = 16
@show n^2
label_org_height = 3.64mm

letter_uniqueness = [
                     ("J", 95),
                     ("Q", 90),
                     ("X", 88),
                     ("Z", 85),
                     ("A", 82),
                     ("W", 80),
                     ("M", 78),
                     ("K", 75),
                     ("S", 73),
                     ("Y", 70),
                     ("H", 68),
                     ("N", 65),
                     ("R", 62),
                     ("G", 60),
                     ("B", 58),
                     ("P", 55),
                     ("V", 52),
                     ("U", 50),
                     ("E", 48),
                     ("C", 45),
                     ("D", 42),
                     ("F", 40),
                     ("T", 38),
                     ("L", 32),
                     ("O", 28),
                     ("I", 20),
                    ]

sort!(letter_uniqueness, by = last, rev = true)

letters = sort(first.(letter_uniqueness[1:n]))

# replace M with the n+1 most unique letter
letter = first(letter_uniqueness[n + 1])
replace!(letters, "M" => letter)
sort!(letters)

excluded_letters = setdiff(string.('A':'Z'), letters)
rhyme = "MILD DILUTED COFFEE"
@assert string.(filter(!isspace, sort(unique(rhyme)))) == excluded_letters
@show rhyme

# rhyme = "Q SAVVY BRASH JAZZY GYPSY YANKS WAX"
# @assert string.(filter(!isspace, sort(unique(rhyme)))) == letters
# @show rhyme

limits = ((0, n), (0, n))

fig = Figure(size = (297mm, 210mm), font = "JuliaMono-Black")
for (row, magnify) in enumerate((1, 1.2)), (col, widen) in enumerate((1, 1.5))
    label_height = magnify*label_org_height
    height = n*label_height
    width = 0.9*1.4n*label_height*widen
    ax = Axis(fig[row, col]; limits, width, height)
    for (y, a) in enumerate(letters), (x, b) in enumerate(letters)
        text!(ax, (x - 0.5, y - 0.5); text = string(a, b), fontsize = 0.8label_height, align = (:center, :center))
    end
    for v in 0:n
        vlines!(ax, v, color = :black, linewidth = 1)
        hlines!(ax, v, color = :black, linewidth = 1)
    end
    hidedecorations!(ax)
end
save("labels.pdf", fig)

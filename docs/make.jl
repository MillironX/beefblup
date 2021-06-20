using BeefBLUP
using Documenter

DocMeta.setdocmeta!(BeefBLUP, :DocTestSetup, :(using BeefBLUP); recursive=true)

makedocs(;
    modules=[BeefBLUP],
    authors="Thomas A. Christensen II <25492070+MillironX@users.noreply.github.com> and contributors",
    repo="https://github.com/MillironX/BeefBLUP.jl/blob/{commit}{path}#{line}",
    sitename="BeefBLUP.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MillironX.github.io/BeefBLUP.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MillironX/BeefBLUP.jl",
    devbranch="develop",
)

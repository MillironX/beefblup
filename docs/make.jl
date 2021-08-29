using BeefBLUP
using Documenter

DocMeta.setdocmeta!(BeefBLUP, :DocTestSetup, :(using BeefBLUP); recursive=true)

makedocs(;
    modules=[BeefBLUP],
    authors="Thomas A. Christensen II <25492070+MillironX@users.noreply.github.com>",
    repo="https://github.com/MillironX/beefblup/blob/{commit}{path}#{line}",
    sitename="beefblup",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://millironx.com/beefblup",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "How to Calculate EPDs" => "how-to-calculate-epds.md",
        "CLI Reference (WIP)" => "beefblup-cli.md"
    ],
)

deploydocs(;
    repo="github.com/MillironX/beefblup",
    devbranch="develop",
)

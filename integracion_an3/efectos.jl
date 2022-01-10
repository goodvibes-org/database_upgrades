### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ 5600516f-46fd-4aa4-92dc-d05a8dcc1056
using OrderedCollections, JSON

# ╔═╡ b6fb7168-35e4-48e5-8951-32ebb795ebad
md"""
# Script para transformar la guia de estilo de Word a un JSON


La función de este script es parsear el documento de word que indica como tratar a los harmonised y suspected a un JSON, para luego poder hacer el reemplazo sencillamente con una función map o similar


"""

# ╔═╡ 7c9d5081-b50b-4b1d-a936-7860ca85ca2a
md"""
 Cargo el texto como un array
"""

# ╔═╡ 7e1549a8-71c0-11ec-3f07-c3aee0e4efdb
open("efectos.txt") do file
	global lines=readlines(file)
end;

# ╔═╡ 7386abbc-9cb9-4281-b68b-ec043240bea2
md"""
Elimino las lineas vacias que se ocacionaron por los saltos de linea
"""

# ╔═╡ 18b27098-6918-4a78-9865-e72a384aa864
begin
	indexes_to_delete=[]
	prevline = nothing
	for (line_number,line_content) ∈ enumerate(lines)
		if line_content == "" && prevline == "" 
			push!(indexes_to_delete, line_number)
		end
		prevline = line_content
	end
	deleteat!(lines,indexes_to_delete)
end;

# ╔═╡ 18f126f4-126f-4726-8f82-67ec4f2174e4
md"""
Cada tres lineas tomo las primeras dos como clave y valor del dict, y la tercera debiera ser una linea en blanco  
"""

# ╔═╡ e5124973-fb34-4fb7-8868-0855680242e9
begin
	datos = OrderedDict{String,String}()
	for (line_number, line_content) ∈ enumerate(lines)
		if line_number % 3 == 0
			datos[lines[line_number - 2]] = lines[line_number - 1]
		end
	end
end

# ╔═╡ 1d5df694-728d-4644-af9d-41718550ffbf
md"""
Exporto los datos como JSON
"""

# ╔═╡ 9057b2f5-bd30-4cd0-8bb7-934090535f71
open("traducciones.json", "w") do f
	JSON.print(f, datos)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
JSON = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
OrderedCollections = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"

[compat]
JSON = "~0.21.2"
OrderedCollections = "~1.4.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "d7fa6237da8004be601e19bd6666083056649918"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
"""

# ╔═╡ Cell order:
# ╠═5600516f-46fd-4aa4-92dc-d05a8dcc1056
# ╟─b6fb7168-35e4-48e5-8951-32ebb795ebad
# ╟─7c9d5081-b50b-4b1d-a936-7860ca85ca2a
# ╠═7e1549a8-71c0-11ec-3f07-c3aee0e4efdb
# ╟─7386abbc-9cb9-4281-b68b-ec043240bea2
# ╠═18b27098-6918-4a78-9865-e72a384aa864
# ╟─18f126f4-126f-4726-8f82-67ec4f2174e4
# ╠═e5124973-fb34-4fb7-8868-0855680242e9
# ╟─1d5df694-728d-4644-af9d-41718550ffbf
# ╠═9057b2f5-bd30-4cd0-8bb7-934090535f71
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 5e958042-3964-11eb-3c45-b5c40a1fd4d1
using DifferentialEquations, Plots , PlutoUI

# ╔═╡ 2048172e-3fad-11eb-0dd0-59fe69f330ae
import Pkg; Pkg.add("DifferentialEquations")

# ╔═╡ 27dba936-3965-11eb-0ff1-e164fb437758
plotly()

# ╔═╡ f9acbad8-3968-11eb-2ff7-0339577c03e6
md" Aprendiendo a usar el paquete de ecuaciones diferenciales

- El primer ejemplo es el pendulo amortiguado pero sin hacer ningun tipo de aproximacion en cuanto al angulo y ademas se le incorpora un slicer para modificar el mismo "

# ╔═╡ 27c56424-3969-11eb-298c-6f450cf576d7
begin
	 θ₀slider=  @bind θ₀ Slider(0:π/12:π/2; default=π/6, show_value=true)
	md""" Angulo: θ₀ $(θ₀slider)"""

end



# ╔═╡ 27e45b08-3965-11eb-24d0-c704d585ecd9


begin
	
	
	
#Constantes

const g = 9.81 # la gravedad enm/s2
L = 1.0 # Longitud de la cuerda del pendulo
β = 0.8
m = 1
#Condiciones iniciales

u₀ = [0, θ₀] # este es un vector de condiciones iniciales, el primero es la velocidad angular y el otro es el angulo
              # notemos que el angulo inicial no es pequeño, esto es porque vamos a resolver numericamente sin tener en cuenta pequeños desplzamientos
tspan = (0.0,10)

#Ahora definimos nuestro problema

function pendulosimple(du,u,p,t)
    Θ = u[1]
    dΘ = u[2]
    du[1] = dΘ
    du[2] = -(g /L)*sin(Θ) - β/m * dΘ
    
end

#Utilizo los solvers
prob = ODEProblem(pendulosimple,u₀,tspan)
sol = solve(prob,Tsit5()) # el Tsit es un metodo de Tsitouras de 5 orden

# Grafico la solucion

plot(sol,linewidth=2, tittle= "Problema de pendulo simple",xaxis="Tiempo",yaxis="Altura",label=["θ:angulo" "w:velocidad angular"])
ylims!(-0.5,0.5)
end
	




# ╔═╡ 27b53e54-3965-11eb-1dbe-99a991c19aff
md" 
### Hola $x$
"

# ╔═╡ Cell order:
# ╠═2048172e-3fad-11eb-0dd0-59fe69f330ae
# ╠═5e958042-3964-11eb-3c45-b5c40a1fd4d1
# ╠═27dba936-3965-11eb-0ff1-e164fb437758
# ╟─f9acbad8-3968-11eb-2ff7-0339577c03e6
# ╠═27c56424-3969-11eb-298c-6f450cf576d7
# ╠═27e45b08-3965-11eb-24d0-c704d585ecd9
# ╠═27b53e54-3965-11eb-1dbe-99a991c19aff

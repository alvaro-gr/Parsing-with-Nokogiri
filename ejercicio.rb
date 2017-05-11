require 'nokogiri'
require 'open-uri'

#URL
url = 'https://www.port-monitor.com/plans-and-pricing'

#Cargamos la pagina
pagina = Nokogiri::HTML(open(url))

#Array para guardar los productos
array_productos = []

#Buscamos los productos navegando por el DOM
productos = pagina.css('div.product')

#Recorremos todos los productos encontrados
productos.each do |producto|
    string1 = producto.css('dd')[0].text
    string2 = producto.css('dd')[1].text
    string3 = producto.css('a')[2].text

    check_rate = string1[6] + string1[7]
    history = string2[0] + string2[1]

    #Expresion regular necesaria para poder encontrar el "precio"
    expr = /\d*\d*\d.\d{2}/
    price = expr.match(string3) #Devuelve un objeto MatchData

    #Cojemos la informacion que nos interese de cada producto
    producto = {'monitors:' => producto.css('h2')[0].text,
                'check_rate:' => check_rate,
                'history:' => history,
                'multiple_notifications:' => producto.css('span')[0].text,
                'push_notifications:' => producto.css('span')[1].text,
                'price:' => price[0]
            }
    #Añadimos el producto al array
    array_productos.push(producto)
end

puts array_productos

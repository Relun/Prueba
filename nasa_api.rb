require "uri"
require "net/http"
require "json"

def request(url, api_key = "evpggbsi2W561hAxhwTJhBdcNtRcQzvBuwCMc05i")
    url = URI(url+"&api_key="+api_key)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Postman-Token"] = 'b884e08a-fb70-4647-93c5-8ab6fd9f6c93'
    response = https.request(request)
    JSON.parse(response.read_body)
   
end

nasa_info =  request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10")

def  build_web_page(data)
    images = data["photos"].map{|e| e['img_src']}.reverse
    # puts images

    cameras = "<!DOCTYPE html>\n<html lang='en'>\n<head>\n\t<meta charset=UTF-8>\n\t<meta http-equiv='X-UA-Compatible' content='IE=edge'>\n\t<meta name='viewport' content='width=device-width, initial-scale=1.0'>\n\t<title>Prueba Nasa</title>\n\t<meta name='author' content='Claudia Araya'>\n</head>\n" 
    cameras += "\t<body style='background-color:#000000'>\n\t\t\t\t\t\t<h1 style='margin-left:4rem; color:#fefefe' > Imágenes del rover Curiosity</h1>\n\t\t\t<h3 style='margin-left:4rem; color:#fefefe'>Nasa API</h3>\n\t\t\t<ul>"

    images.each do |image|
        cameras += "\n\t\t\t\t<li><img\tsrc='#{image}' style='width:25vw; margin-bottom:2rem'></li>"
    end
    cameras += "\n\t\t</ul>\n\t</body>\n</html>"
    File.write('nasaweb.html', cameras)
end
build_web_page(nasa_info)


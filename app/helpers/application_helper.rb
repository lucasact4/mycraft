require 'httparty'

module ApplicationHelper

  def gravatar_for(user, options = { size: 80 })
    # Substitua <username> pelo nome do jogador que você deseja encontrar o UUID
    username = user.playername.downcase
    mojang_api_url = "https://api.mojang.com/users/profiles/minecraft/#{username}"
    response = HTTParty.get(mojang_api_url)

    # Verifique se a resposta foi bem-sucedida antes de prosseguir
    if response.code == 200
      # Extrai o UUID do jogador da resposta JSON
      uuid = response.parsed_response["id"]
      size = options[:size]
      url = "https://crafatar.com/renders/head/#{uuid}?overlay"
      image_tag(url, alt: user.playername, class: "minecraft-skin", width: size, height: size)

      # Faça o que quiser com a URL do avatar do jogador aqui
    else
      size = options[:size]
      url = "https://crafatar.com/renders/head/46e99f12-6e8b-4a04-a8e9-e8bb8a616470?overlay"
      image_tag(url, alt: user.playername, class: "minecraft-skin", width: size, height: size)
    end
  end

end

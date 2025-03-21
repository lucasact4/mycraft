class AddDefaultPlayers < ActiveRecord::Migration[6.0]
  def up
    # Criar o primeiro usuário
    Player.create!(
      playername: "act4_",
      email: "funcraftact4@outlook.com",
      password: "password",
      password_confirmation: "password",
      name: "Lucas Vitor",
      admin: true
    )

    # Criar o segundo usuário
    Player.create!(
      playername: "test",
      email: "test@outlook.com", # Se precisar de email também
      password: "password",
      password_confirmation: "password",
      name: "Teste",
      admin: false
    )
  end

  def down
    Player.where(playername: ["act4_", "teste"]).destroy_all
  end
end

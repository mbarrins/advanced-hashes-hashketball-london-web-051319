require "pry"

def game_hash
  {
    :home =>
      {
        :team_name => "Brooklyn Nets",
        :colors => ["Black", "White"],
        :players =>
          {
            "Alan Anderson" =>
              {
                number: 0,
                shoe: 16,
                points: 22,
                rebounds: 12,
                assists: 12,
                steals: 3,
                blocks: 1,
                slam_dunks: 1
              },
            "Reggie Evans" =>
              {
                number: 30,
                shoe: 14,
                points: 12,
                rebounds: 12,
                assists: 12,
                steals: 12,
                blocks: 12,
                slam_dunks: 7
              },
            "Brook Lopez" =>
              {
                number: 11,
                shoe: 17,
                points: 17,
                rebounds: 19,
                assists: 10,
                steals: 3,
                blocks: 1,
                slam_dunks: 15
              },
            "Mason Plumlee" =>
              {
                number: 1,
                shoe: 19,
                points: 26,
                rebounds: 12,
                assists: 6,
                steals: 3,
                blocks: 8,
                slam_dunks: 5
              },
            "Jason Terry" =>
              {
                number: 31,
                shoe: 15,
                points: 19,
                rebounds: 2,
                assists: 2,
                steals: 4,
                blocks: 11,
                slam_dunks: 1
              }
          }
      },
    :away =>
      {
        :team_name => "Charlotte Hornets",
        :colors => ["Turquoise", "Purple"],
        :players =>
          {
            "Jeff Adrien" =>
              {
                number: 4,
                shoe: 18,
                points: 10,
                rebounds: 1,
                assists: 1,
                steals: 2,
                blocks: 7,
                slam_dunks: 2
              },
            "Bismak Biyombo" =>
              {
                number: 0,
                shoe: 16,
                points: 12,
                rebounds: 4,
                assists: 7,
                steals: 7,
                blocks: 15,
                slam_dunks: 10
              },
            "DeSagna Diop" =>
              {
                number: 2,
                shoe: 14,
                points: 24,
                rebounds: 12,
                assists: 12,
                steals: 4,
                blocks: 5,
                slam_dunks: 5
              },
            "Ben Gordon" =>
              {
                number: 8,
                shoe: 15,
                points: 33,
                rebounds: 3,
                assists: 2,
                steals: 1,
                blocks: 1,
                slam_dunks: 0
              },
            "Brendan Haywood" =>
              {
                number: 33,
                shoe: 15,
                points: 6,
                rebounds: 12,
                assists: 12,
                steals: 22,
                blocks: 5,
                slam_dunks: 12
              }
          }
      }
  }
end

# def good_practices
#   game_hash.each do |location, team_data|
#     #are you ABSOLUTELY SURE what 'location' and 'team data' are? use binding.pry to find out!
#     binding.pry
#       team_data.each do |attribute, data|
#         #are you ABSOLUTELY SURE what 'attribute' and 'team data' are? use binding.pry to find out!
#         binding.pry
#
#         #what is 'data' at each loop through out .each block? when will the following line of code work and when will it break?
#         data.each do |data_item|
#             binding.pry
#       end
#     end
#   end
# end
#
# good_practices


def num_points_scored(player)
  game_hash.each do |location, team_data|
    return team_data[:players][player][:points] if team_data[:players].has_key?(player)
  end
end

def shoe_size(player)
  game_hash.each do |location, team_data|
    return team_data[:players][player][:shoe] if team_data[:players].has_key?(player)
  end
end

def team_colors(team)
  game_hash.each do |location, team_data|
    return team_data[:colors] if team_data[:team_name] == team
  end
end

def team_names
  game_hash.values.map {|team| team[:team_name]}
end

def player_numbers(team)
  game_hash.values.each do |location|
    if location[:team_name] == team
      return location[:players].map {|player, detail| detail[:number]}
    end
  end
end

def player_stats(player)
  game_hash.each do |location, team_data|
    return team_data[:players][player] if team_data[:players].has_key?(player)
  end
end

def big_shoe_rebounds
  max_shoe_size = 0
  max_shoe_player = ""
  max_shoe_rebounds = 0

  player_hash = game_hash.values.map {|location| location[:players]}.flatten
  # binding.pry
  player_hash.each do |player|
    player.each do |name, details|
    # binding.pry
      if max_shoe_size < details[:shoe]
        max_shoe_size = details[:shoe]
        max_shoe_player = name
        max_shoe_rebounds = details[:rebounds]
      end
    end
  end

  max_shoe_rebounds
end

def most_points_scored
  max_points = 0
  max_points_player = ""

  player_hash = game_hash.values.map {|location| location[:players]}.flatten
  # binding.pry
  player_hash.each do |player|
    player.each do |name, details|
    # binding.pry
      if max_points < details[:points]
        max_points = details[:points]
        max_points_player = name
      end
    end
  end
  max_points_player
end

def winning_team
  team_name = ""
  points = 0
  game_hash.each do |location, team|
    team_points = 0
    team[:players].each {|player, details| team_points += details[:points]}
    if team_points > points
      points = team_points
      team_name = team[:team_name]
    end
  end
  team_name
end

def player_with_longest_name
  longest_name = ""

  game_hash.values.map {|location| location[:players]}.flatten.each do |player|
    player.each do |name, details|
      longest_name = name if longest_name.length < name.length
    end
  end
  longest_name
end

def long_name_steals_a_ton?
  most_steals = ""
  game_hash.values.map {|location| location[:players]}.flatten.each do |players|
      most_steals = players.transform_values{|details| details[:steals]}.max_by{|name, steals| steals}[0]
      # binding.pry
  end
  player_with_longest_name == most_steals
end

puts num_points_scored("Reggie Evans")
puts num_points_scored("Brendan Haywood")
puts
puts shoe_size("Reggie Evans")
puts shoe_size("Brendan Haywood")
puts
puts team_colors("Brooklyn Nets").inspect
puts team_colors("Charlotte Hornets").inspect
puts
puts team_names.inspect
puts
puts player_numbers("Brooklyn Nets").inspect
puts player_numbers("Charlotte Hornets").inspect
puts
puts player_stats("Reggie Evans").inspect
puts player_stats("Brendan Haywood").inspect
puts
puts big_shoe_rebounds
puts
puts most_points_scored
puts winning_team
puts
puts player_with_longest_name
puts
puts long_name_steals_a_ton?

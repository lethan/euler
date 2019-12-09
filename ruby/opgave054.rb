# frozen_string_literal: true

def card_cmp(card1, card2)
  a_value = card1[0]
  b_value = card2[0]
  return 0 if a_value == b_value
  return -1 if a_value == 'A'
  return 1 if b_value == 'A'
  return -1 if a_value == 'K'
  return 1 if b_value == 'K'
  return -1 if a_value == 'Q'
  return 1 if b_value == 'Q'
  return -1 if a_value == 'J'
  return 1 if b_value == 'J'
  return -1 if a_value == 'T'
  return 1 if b_value == 'T'

  b_value <=> a_value
end

def hand_sort!(hand)
  hand.sort! { |a, b| card_cmp(a, b) }
end

def flush?(hand)
  suit = hand[0][1]
  hand.each do |card|
    return false if card[1] != suit
  end
  true
end

def straight(hand)
  straight = false
  high_card = nil
  case (first_card = hand[0][0])
  when 'A'
    if hand[4][0] == 'T'
      straight = true
      high_card = first_card
    end
    if hand[1][0] == '5' && hand[4][0] == '2'
      straight = true
      high_card = hand[1][0]
    end
  when 'K'
    if hand[4][0] == '9'
      straight = true
      high_card = first_card
    end
  when 'Q'
    if hand[4][0] == '8'
      straight = true
      high_card = first_card
    end
  when 'J'
    if hand[4][0] == '7'
      straight = true
      high_card = first_card
    end
  when 'T'
    if hand[4][0] == '6'
      straight = true
      high_card = first_card
    end
  when '9'
    if hand[4][0] == '5'
      straight = true
      high_card = first_card
    end
  when '8'
    if hand[4][0] == '4'
      straight = true
      high_card = first_card
    end
  when '7'
    if hand[4][0] == '3'
      straight = true
      high_card = first_card
    end
  when '6'
    straight = true
    high_card = first_card
  end
  [straight, high_card]
end

def hand_rank(hand)
  rank_count = {}
  hand.each do |card|
    rank_count[card[0]] = 0 if rank_count[card[0]].nil?
    rank_count[card[0]] += 1
  end
  rank_sort = rank_count.sort { |a, b| b[1] <=> a[1] }
  case rank_sort[0][1]
  when 4
    [:four_of_kind, rank_sort[0][0]]
  when 3
    if rank_sort[1][1] == 1
      [:three_of_kind, rank_sort[0][0]]
    else
      [:full_house, rank_sort[0][0], rank_sort[1][0]]
    end
  when 2
    if rank_sort[1][1] == 1
      [:one_pair, rank_sort[0][0]]
    else
      [:two_pairs, rank_sort[0][0], rank_sort[1][0]]
    end
  when 1
    result = [:high_card, rank_sort[0][0]]
    straight = straight(hand)
    if straight[0]
      result = if flush?(hand)
                 [:straight_flush, straight[1]]
               else
                 [:straight, straight[1]]
               end
    elsif flush?(hand)
      result = [:flush, rank_sort[0][0]]
    end
    result
  end
end

def winning_poker_hand(hand1, hand2)
  hand_sort!(hand1)
  hand_sort!(hand2)
  hand_rank1 = hand_rank(hand1)
  hand_rank2 = hand_rank(hand2)

  if hand_rank1[0] == :straight_flush
    return 1 if hand_rank2[0] != :straight_flush
    return 0 if hand_rank1[1] == hand_rank2[1]

    return -card_cmp(hand_rank1[1], hand_rank2[1])
  end
  return -1 if hand_rank2[0] == :straight_flush

  if hand_rank1[0] == :four_of_kind
    return 1 if hand_rank2[0] != :four_of_kind

    cmp = -card_cmp(hand_rank1[1], hand_rank2[1])
    return cmp unless cmp.zero?

    hand1.each_with_index do |_, index|
      cmp = -card_cmp(hand1[index], hand2[index])
      return cmp unless cmp.zero?
    end
    return 0
  end
  return -1 if hand_rank2[0] == :four_of_kind

  if hand_rank1[0] == :full_house
    return 1 if hand_rank2[0] != :full_house

    cmp = -card_cmp(hand_rank1[1], hand_rank2[1])
    return cmp unless cmp.zero?

    return -card_cmp(hand_rank1[2], hand_rank2[2])
  end
  return -1 if hand_rank2[0] == :full_house

  if hand_rank1[0] == :flush
    return 1 if hand_rank2[0] != :flush

    hand1.each_with_index do |_, index|
      cmp = -card_cmp(hand1[index], hand2[index])
      return cmp unless cmp.zero?
    end
    return 0
  end
  return -1 if hand_rank2[0] == :flush

  if hand_rank1[0] == :straight
    return 1 if hand_rank2[0] != :straight

    return -card_cmp(hand_rank1[1], hand_rank2[1])
  end
  return -1 if hand_rank2[0] == :straight

  if hand_rank1[0] == :three_of_kind
    return 1 if hand_rank2[0] != :three_of_kind

    cmp = -card_cmp(hand_rank1[1], hand_rank2[1])
    return cmp unless cmp.zero?

    hand1.each_with_index do |_, index|
      cmp = -card_cmp(hand1[index], hand2[index])
      return cmp unless cmp.zero?
    end
    return 0
  end
  return -1 if hand_rank2[0] == :three_of_kind

  if hand_rank1[0] == :two_pairs
    return 1 if hand_rank2[0] != :two_pairs

    cmp = -card_cmp(hand_rank1[1], hand_rank2[1])
    return cmp unless cmp.zero?

    cmp = -card_cmp(hand_rank1[2], hand_rank2[2])
    return cmp unless cmp.zero?

    hand1.each_with_index do |_, index|
      cmp = -card_cmp(hand1[index], hand2[index])
      return cmp unless cmp.zero?
    end
    return 0
  end
  return -1 if hand_rank2[0] == :two_pairs

  if hand_rank1[0] == :one_pair
    return 1 if hand_rank2[0] != :one_pair

    cmp = -card_cmp(hand_rank1[1], hand_rank2[1])
    return cmp unless cmp.zero?

    hand1.each_with_index do |_, index|
      cmp = -card_cmp(hand1[index], hand2[index])
      return cmp unless cmp.zero?
    end
    return 0
  end
  return -1 if hand_rank2[0] == :one_pair

  hand1.each_with_index do |_, index|
    cmp = -card_cmp(hand1[index], hand2[index])
    return cmp unless cmp.zero?
  end
  0
end

player_one_wins = 0
file = File.open('p054_poker.txt', 'r')
while (line = file.gets)
  cards = line.strip.split(' ')
  hands = cards.each_slice(5).to_a
  player_one_wins += 1 if winning_poker_hand(hands[0], hands[1]) == 1
end
file.close
puts player_one_wins

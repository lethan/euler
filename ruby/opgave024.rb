# frozen_string_literal: true

permutation = 0
(0..9).each do |first|
  break if permutation >= 1_000_000

  (0..9).each do |second|
    break if permutation >= 1_000_000
    next if [first].include?(second)

    (0..9).each do |third|
      break if permutation >= 1_000_000
      next if [first, second].include?(third)

      (0..9).each do |fourth|
        break if permutation >= 1_000_000
        next if [first, second, third].include?(fourth)

        (0..9).each do |fifth|
          break if permutation >= 1_000_000
          next if [first, second, third, fourth].include?(fifth)

          (0..9).each do |sixth|
            break if permutation >= 1_000_000
            next if [first, second, third, fourth, fifth].include?(sixth)

            (0..9).each do |seventh|
              break if permutation >= 1_000_000
              next if [first, second, third, fourth, fifth, sixth].include?(seventh)

              (0..9).each do |eighth|
                break if permutation >= 1_000_000
                next if [first, second, third, fourth, fifth, sixth, seventh].include?(eighth)

                (0..9).each do |ninth|
                  break if permutation >= 1_000_000
                  next if [first, second, third, fourth, fifth, sixth, seventh, eighth].include?(ninth)

                  (0..9).each do |tenth|
                    break if permutation >= 1_000_000
                    next if [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth].include?(tenth)

                    permutation += 1
                    puts [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth].map(&:to_s).join if permutation == 1_000_000
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

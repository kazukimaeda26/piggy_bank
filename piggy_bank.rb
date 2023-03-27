# お金
class Money
    attr_reader :amount, :damage, :unit

    def initialize(amount, damage, unit)
        @amount = amount
        @damage = damage
        @unit = unit
    end
end

# 合計金額を計算する処理
def calcAmount(money_arr)
    total_amount = 0
    number_of_coins = 0
    number_of_banknotes = 0
    number_of_exclusions = 0

    coins = [1, 5, 10, 100, 500]
    coins_or_banknotes = [1, 5, 10, 100, 500, 1000, 2000, 5000, 10000]
    units = ["円", "えん", "yen", "YEN"]

    for money in money_arr do
        if !coins_or_banknotes.include?(money.amount)
            puts "Error: 1度に複数の硬貨または紙幣を入れないでください"
            return nil
        end
        if money.damage or !units.include?(money.unit)
            number_of_exclusions += 1
            next
        end
        if coins.include?(money.amount)
            number_of_coins += 1
        else
            number_of_banknotes += 1
        end
        total_amount += money.amount
    end
    return total_amount, number_of_banknotes, number_of_coins, number_of_exclusions
end

# 呼び出し元
def calc()
    # 投入するお金
    money1 = Money.new(500, false, "円")
    money2 = Money.new(1000, false, "円")
    money3 = Money.new(5, false, "円")
    money4 = Money.new(1, false, "円") 
    money5 = Money.new(5000, false, "円")
    money_arr = []
    money_arr.push(money1)
    money_arr.push(money2)
    money_arr.push(money3)
    money_arr.push(money4)
    money_arr.push(money5)

    # 合計金額を計算する処理を呼び出す
    total_amount, number_of_banknotes, number_of_coins, number_of_exclusions = calcAmount(money_arr)
    
    # 標準出力に結果を出力
    if total_amount
        puts("合計:#{total_amount}")
        puts("紙幣の枚数:#{number_of_banknotes}")
        puts("硬貨の枚数:#{number_of_coins}")
        puts("対象外の枚数:#{number_of_exclusions}")
    end
end
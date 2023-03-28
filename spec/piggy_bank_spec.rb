require_relative '../piggy_bank'

RSpec.describe '貯金箱' do
    before do
        money1 = Money.new(500, false, "円")
        money2 = Money.new(1000, false, "円")
        money3 = Money.new(5, false, "円")
        money4 = Money.new(1, false, "円") 
        money5 = Money.new(5000, false, "円")
        @money_arr = []
        @money_arr.push(money1)
        @money_arr.push(money2)
        @money_arr.push(money3)
        @money_arr.push(money4)
        @money_arr.push(money5)
    end

    context '複数の紙幣や硬貨が必要な金額(333円など)が1度に投入された場合' do
        it '標準出力にErrorを表示し, nilを返すこと' do
            @money_arr[0] = Money.new(333, false, "円")
            expect{ calcAmount(@money_arr) }.to output("Error: 複数の紙幣や硬貨の組み合わせのみで実現できる金額(333円など)が投入されています\n").to_stdout
            expect(calcAmount(@money_arr)).to eq nil
        end
    end

    context '全て「傷なし」かつ「単位が円」のお金の場合' do
        it '合計、紙幣の枚数、硬貨の枚数、対象外の枚数が正しく返ってくること' do
            expect(calcAmount(@money_arr)).to eq [6506, 2, 3, 0]
        end
    end

    context '「傷あり」のお金を含む場合' do
        it '合計、紙幣の枚数、硬貨の枚数、対象外の枚数が正しく返ってくること' do
            @money_arr[0] = Money.new(500, true, "円")
            @money_arr[4] = Money.new(5000, true, "円")
            expect(calcAmount(@money_arr)).to eq [1006, 1, 2, 2]
        end
    end

    context '「単位が円」以外のお金を含む場合' do
        it '単位が「えん」「yen」、「YEN」の場合にも日本円としてカウントされ正しく返ってくること' do
            @money_arr[0] = Money.new(500, false, "えん")
            @money_arr[1] = Money.new(1000, false, "yen")
            @money_arr[2] = Money.new(5, false, "YEN")
            expect(calcAmount(@money_arr)).to eq [6506, 2, 3, 0]
        end

        it '日本円でないお金が含まれる場合に正しく返ってくること' do
            @money_arr[0] = Money.new(500, false, "ドル")
            @money_arr[1] = Money.new(1000, false, "ペソ")
            @money_arr[2] = Money.new(5, false, "ユーロ")
            expect(calcAmount(@money_arr)).to eq [5001, 1, 1, 3]
        end
    end

    context '「傷あり」と「日本円でない」お金が混在している場合' do
        it '正しく返ってくること' do
            @money_arr[2] = Money.new(5, false, "ユーロ")
            @money_arr[3] = Money.new(1, true, "円")
            @money_arr[4] = Money.new(5000, true, "シリング")
            expect(calcAmount(@money_arr)).to eq [1500, 1, 1, 3]
        end
    end
end
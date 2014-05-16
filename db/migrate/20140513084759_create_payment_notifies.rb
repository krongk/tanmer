##序号,凭证单号,发生金额,情况[入账,支出],类型,状态, 发生日期,
class CreatePaymentNotifies < ActiveRecord::Migration
  def change
    create_table :payment_notifies do |t|
      t.references :payment, index: true
      t.string :payment_number
      t.decimal :payment_count, :precision => 8, :scale => 2
      t.string :state
      t.string :cate
      t.string :status

      t.timestamps
    end
  end
end

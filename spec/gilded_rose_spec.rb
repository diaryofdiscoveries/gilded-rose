require 'spec_helper'
require 'gilded_rose'

describe GildedRose do
  describe '#update_quality' do
    shared_examples 'normal item sell in' do |item_name|
      it 'lowers sell in value by 1 at the end of the day' do
        item = Item.new(item_name, sell_in = 1, quality = 0)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality

        expect(item.sell_in).to eq 0
      end

      it 'lowers sell in value by n after n days' do
        n = 10
        item = Item.new(item_name, sell_in = n, quality = 0)
        items = [item]
        gilded_rose = described_class.new(items)

        n.times do |i|
          gilded_rose.update_quality
          expect(item.sell_in).to eq (n - (i + 1))
        end

        expect(item.sell_in).to eq 0
      end

      it 'sell in value can be negative' do
        item = Item.new(item_name, sell_in = 0, quality = 0)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality

        expect(item.sell_in).to eq -1
      end
    end

    shared_examples 'quality value' do |item_name|
      it 'quality value is never negative' do
        item = Item.new(item_name, sell_in = 0, quality = 0)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality

        expect(item.quality).to eq 0
      end

      it 'quality value is never more than 50' do
        item = Item.new(item_name, sell_in = 20, quality = 50)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality

        expect(item.quality).to be <= 50
      end
    end

    # Normal item

    context 'item name' do
      it 'does not change the name' do
        item = Item.new('foo', sell_in = 0, quality = 0)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality

        expect(item.name).to eq 'foo'
      end
    end

    it_behaves_like 'normal item sell in', item_name = 'foo'

    context 'item quality' do
      it_behaves_like 'quality value', item_name = 'foo'

      context 'when sell in date not passed yet' do
        it 'lowers quality value by 1 at the end of the day' do
          item = Item.new('foo', sell_in = 1, quality = 1)
          items = [item]
          gilded_rose = described_class.new(items)
          gilded_rose.update_quality

          expect(item.quality).to eq 0
        end

        it 'lowers quality value by n after n days' do
          n = 10
          item = Item.new('foo', sell_in = n, quality = n)
          items = [item]
          gilded_rose = described_class.new(items)

          n.times do |i|
            gilded_rose.update_quality
            expect(item.quality).to eq (n - (i + 1))
          end

          expect(item.quality).to eq 0
        end
      end

      context 'when sell in date has passed' do
        it 'lowers quality value by 2 at the end of the day' do
          item = Item.new('foo', sell_in = 0, quality = 4)
          items = [item]
          gilded_rose = described_class.new(items)
          gilded_rose.update_quality

          expect(item.quality).to eq 2
        end

        it 'lowers quality value twice as fast after n days' do
          n = 5
          quality = 15
          item = Item.new('foo', sell_in = 0, quality = quality)
          items = [item]
          gilded_rose = described_class.new(items)

          n.times do |i|
            gilded_rose.update_quality
            expect(item.quality).to eq (quality - (2 * (i + 1)))
          end

          expect(item.quality).to eq (quality - (2 * n))
        end
      end
    end
  end
end

# encoding: UTF-8
class PolishNumberTranslator
  def self.hello
    puts ""
  end

  def self.translate(number)
    initialize
    map_translation(number)
    # def translate
  end
  private
  def self.initialize
    @@cardinal_numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
    @@cardinal_numbers_mapping = {
      '0' => 'zero',
      '1' => 'jeden',
      '2' => 'dwa',
      '3' => 'trzy',
      '4' => 'cztery',
      '5' => 'pięć',
      '6' => 'sześć',
      '7' => 'siedem',
      '8' => 'osiem',
      '9' => 'dziewięć'
    }

    @@decimal_numbers = ['10', '20', '30', '40', '50', '60', '70', '80', '90' ]
    @@decimal_numbers_mapping = {
      '10' => 'dziesięć',
      '20' => 'dwadzieścia',
      '30' => 'trzydzieści',
      '40' => 'czterdzieści',
      '50' => 'pięćdziesiąt',
      '60' => 'sześćdziesiąt',
      '70' => 'siedemdziesiąt',
      '80' => 'osiemdziesiąt',
      '90' => 'dziewięćdziesiąt'
    }

    @@hundred_numbers = ['100', '200', '300', '400', '500', '600', '700', '800', '900']
    @@hundred_numbers_mapping = {
      '100' => 'sto',
      '200' => 'dwieście',
      '300' => 'trzysta',
      '400' => 'czterysta',
      '500' => 'pięćset',
      '600' => 'sześćset',
      '700' => 'siedemset',
      '800' => 'osiemset',
      '900' => 'dziewięćset'
    }
    @@thousand = '1000'
    @@thousand_mapping = {
      '1' => 'tysiąc',
      '2,3,4' => 'tysiące',
      '5,6,7,8,9' => 'tysięcy',
      '0' => 'tysięcy'
    }

    @@milion = '1000000'
    @@milion_mapping = {
      '1' => 'milion',
      '2,3,4' => 'miliony',
      '5,6,7,8,9' => 'milionów',
      '0' => 'milionów'
    }
    @@miliard = '1000000000'
    @@miliard_mapping = {
      '1' => 'miliard',
      '2,3,4' => 'miliardy',
      '5,6,7,8,9' => 'miliardów',
      '0' => 'miliardów'
    }

    # def initialize
  end

  def self.map_translation(number)
    output = []
    case number.length
    when 1
      output << @@cardinal_numbers_mapping[number]
    when 2
      if number[1] == '0'
        output << @@decimal_numbers_mapping[number]
      elsif number[0] == '1'
        output << numbers_between10_and_20(number)
      else
        output << @@decimal_numbers_mapping[(number[0] + '0')]
        output << @@cardinal_numbers_mapping[number[1]]
      end
    when 3
      output << @@hundred_numbers_mapping[(number[0] + '00')]
      output << map_translation(number[1,2])
    when 4
      if number[0] == '1'
        output << @@thousand_mapping['1']
      else
        output << @@cardinal_numbers_mapping[number[0]]
        @@thousand_mapping.each {|key,value| output << value if key.include?(number[0])}
      end
      output << map_translation(number[1,3])
    when 5
      output << map_translation(number[0,2])
      if number != '1'
        @@thousand_mapping.each {|key,value| output << value if key.include?(number[0])}
      else
        output << @@thousand_mapping['0']
      end
      output << map_translation(number[-3,3]) if number[-3,3] != '000'
    when 6
      output << map_translation(number[0,3])
      if (number[1] != '1' && number[2] != '1') && number[0,3] != '000'
        @@thousand_mapping.each{|key,value| output << value if key.include?(number[2])}
      elsif number[0,3] != '000'
        output << @@thousand_mapping['0']
      end
      output << map_translation(number[-3,3])
    when 7
      if number[0] == '1'
        output << @@milion_mapping['1']
      else
        output << map_translation(number[0])
        @@milion_mapping.each {|key,value| output << value if key.include?(number[0])}
      end
      output << map_translation(number[1,6]) if number[1,6] != '000000'
    when 8
      output << map_translation(number[0,2])
      if number[0] != '1'
        @@milion_mapping.each {|key,value| output << value if key.include?(number[1])}
      else
        output << @@milion_mapping['0']
      end
      output << map_translation(number[2,6]) if number[2,6] != '000000'
    when 9
      output << map_translation(number[0,3])
      if number[1] != '1'
        @@milion_mapping.each {|key,value| output << value if key.include?(number[1])}
      else
        output << @@milion_mapping['0']
      end
      output << map_translation(number[-6,6]) if number[-6,6] != '000000'
    when 10
      if number[0] == '1'
        output << @@miliard_mapping['1']
      else
        output << map_translation(number[0])
        @@miliard_mapping.each{|key,value| output << value if key.include?(number[0])}
      end
      output << map_translation(number[1,9]) if number[1,9] != '000000000'
    when 11
      output << map_translation(number[0,2])
      if number[0] != '1'
        @@miliard_mapping.each {|key,value| output << value if key.include?(number[1])}
      else
        output << @@miliard_mapping['0']
      end
      output << map_translation(number[2,9]) if number[2,9] != '000000000'
    when 12
      output << map_translation(number[0,3])
      if number[1] != '1'
        @@miliard_mapping.each {|key,value| output << value if key.include?(number[1])}
      else
        output << @@miliard_mapping['0']
      end
      output << map_translation(number[-9,9]) if number[-9,9] != '000000000'
    end
    return output.join(" ").strip
    # def map_translation
  end

  def self.numbers_between10_and_20(number)
    case number[1]
    when '1'
      @@cardinal_numbers_mapping[number[1]] + "aście"
    when '2', '3', '7', '8'
      @@cardinal_numbers_mapping[number[1]] + "naście"
    when '4'
      @@cardinal_numbers_mapping[number[1]].chop + "nascie"
    when '5', '9'
      @@cardinal_numbers_mapping[number[1]].chop + "tnaście"
    when '6'
      @@cardinal_numbers_mapping[number[1]][0..2] + "snaście"
    end
    # def between10_and_20
  end

  # module NumberTranslator
end

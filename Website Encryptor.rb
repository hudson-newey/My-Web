#!/usr/bin/env ruby
=begin
Labyrinth Copyright (C) 2018 Grathium Sofwares <grathiumsoftwears@gmail.com>
This program comes with ABSOLUTELY NO WARRANTY
This is a free software, and you are welcome to redistribute it under certain
conditions.
=end

class Encryptor
	$end_file=''

	def cipher(rotation)
		characters = (' '..'z').to_a
		offset_characters = characters.rotate(rotation)
		pairs = characters.zip(offset_characters)
		Hash[pairs]

	end

	def encrypt_letter(letter,rotation)
		cipher_for_rotation = cipher(rotation)
		cipher_for_rotation[letter]
	end

	def encrypt(string,rotation)
		letters = string.split('')

		results = letters.collect do |letter|
			encrypted_letter = encrypt_letter(letter, rotation)
		end
			
		results.join
		results = results.to_s
		results.delete! '[]""'
		results.gsub! 'nil', ''
		return results

	end


  def encrypt_file(filename, rotation)

    # Create the file handle to the input file
    message = File.open(filename, "r")
    # Read the text of the input file
    read_message = message.read
    # Encrypt the text
    encrypted_message = encrypt(read_message, rotation)
    # Create a name for the output file
    encrypted_filename = "#{filename}.encrypted"
    # Create an output file handle
    output_message = File.open(encrypted_filename, "w")
    # Write out the text
    output_message.write(encrypted_message)
    # Close the file
    output_message.close

  end
  
  def get_lambda(char)
	val = char.sum
	
	dynamicvar = $c
	if (dynamicvar=="" || dynamicvar==nil)
		dynamicvar = 1
	else 
		if (dynamicvar==0)
			dynamicvar = 1
		end
	end
	
	#$c = (dynamicvar * val)/2*(1-(dynamicvar * val)/2)/((dynamicvar * dynamicvar) *2)
	encrypted_char = encrypt(char, $c)
	return encrypted_char
  end
  
  def read_file(filename)
	clear = File.open(filename) #open the file and set it as a variable
	cleartxt = clear.read
	
	#read the file letter by letter and get the corrosponding lambda
	i = 0
	while i <= cleartxt.size
		
		encchar = cleartxt[i..i]
		$end_file = $end_file + get_lambda(encchar)
		
		system "cls"
		puts "#$end_file"
		i+=1
	end
	
	clear.close
  end

end

$end_file=''
e = Encryptor.new

puts "What is the file extension you'd like to encrypt?"
print "> "
file_to_encrypt = gets.chomp
if (!File.file?(file_to_encrypt))
	abort("Error 404, file not found!")
end

puts "
Secure File Password,"
print "> "
$c = gets.chomp.sum.to_i


e.read_file(file_to_encrypt)

#make the output file
encrypted_filename = "#{file_to_encrypt}.enc"
output_message = File.open(encrypted_filename, "w")
output_message.write($end_file)
output_message.close
puts "Done!"
gets

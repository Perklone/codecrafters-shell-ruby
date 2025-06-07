# Uncomment this block to pass the first stage
$stdout.write("$ ")

# Wait for user input
while true do
    command, *args = gets.chomp.split(" ")
    $stdout.write("#{command}: command not found\n")
end
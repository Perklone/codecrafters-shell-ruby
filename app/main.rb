# Wait for user input
while true do
    $stdout.write("$ ")
    command, *args = gets.chomp.split(" ")

    exit 0 if command == "exit" && args[0] == "0"
    $stdout.write("#{command}: command not found\n")
end
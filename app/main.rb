def parse_command(command, args)
    case command
    when "echo"
        words = args.join(' ')
        $stdout.write("#{words}\n")
    when "exit"
        exit 0 if args[0] == "0"
    else
        $stdout.write("#{command}: command not found\n")
    end
end

# Wait for user input
while true do
    $stdout.write("$ ")
    command, *args = gets.chomp.split(" ")
    parse_command(command, args)
end
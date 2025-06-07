@builtin_command = ["echo", "exit", "type"]

def parse_command(command, args)
    puts args
    case command
    when "type"
        if @builtin_command.include?(args[0])
            $stdout.write("#{args[0]} is a shell builtin\n")
        elsif is_from_file?(args)
            return
        else
            $stdout.write("#{args[0]}: not found\n")
        end
    when "echo"
        words = args.join(' ')
        $stdout.write("#{words}\n")
    when "exit"
        exit 0 if args[0] == "0"
    else
        $stdout.write("#{command}: command not found\n")
    end
end

def is_from_file?(args)
    list_paths = ENV['PATH'].split(File::PATH_SEPARATOR)
    find_path = list_paths.find { |path| path.include?(args[0])}
    if !find_path.empty?
        $stdout.write("#{args[0]} is #{find_path}\n")
        true
    else
        false
    end
end

# Wait for user input
while true do
    $stdout.write("$ ")
    command, *args = gets.chomp.split(" ")
    parse_command(command, args)
end
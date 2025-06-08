@builtin_command = ["echo", "exit", "type", "pwd"]

def parse_command(command, args)
    case command
    when "type"
        if @builtin_command.include?(args[0])
            $stdout.write("#{args[0]} is a shell builtin\n")
        elsif (path = is_from_file?(args[0]))
            $stdout.write("#{args[0]} is #{path}\n")
        else
            $stdout.write("#{args[0]}: not found\n")
        end
    when "echo"
        words = args.join(' ')
        $stdout.write("#{words}\n")
    when "pwd"
        $stdout.write("#{Dir.pwd}\n")
    when "exit"
        exit 0 if args[0] == "0"
    else
        exec = execute_program(command, args)
        if !exec.nil?
            system(exec, args.join(" "))
        else
            $stdout.write("#{command}: command not found\n")
        end
    end
end

def is_from_file?(command)
    list_paths = ENV['PATH'].split(File::PATH_SEPARATOR)

    list_paths.each do |directories|
        path = File.join(directories,command)
        return path if File.file?(path)
    end

    nil
end

def execute_program(executable, arg)
    list_paths = ENV['PATH'].split(File::PATH_SEPARATOR)
    exec_arg = arg.join(" ")

    list_paths.each do |directories|
        path = File.join(directories,executable)
        return executable if File.executable?(path)
    end
    nil
end

# Wait for user input
while true do
    $stdout.write("$ ")
    command, *args = gets.chomp.split(" ")
    parse_command(command, args)
end
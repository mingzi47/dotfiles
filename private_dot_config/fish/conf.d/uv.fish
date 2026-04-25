# 自动激活/退出虚拟环境
function __auto_source_venv --on-variable PWD
    status --is-command-substitution; and return

    # 检查当前目录是否有 .venv 文件夹
    if test -f ".venv/bin/activate.fish"
        # 如果有，则激活它
        source .venv/bin/activate.fish
        echo "Activated virtual environment: .venv"
    else
        # 如果没有，检查是否在虚拟环境中（通过 VIRTUAL_ENV 变量）
        if set -q VIRTUAL_ENV
            # 如果 VIRTUAL_ENV 指向的目录不存在于当前路径树中，则退出
            if not string match -q -- "$VIRTUAL_ENV/*" (pwd)
                deactivate
                echo "Deactivated virtual environment."
            end
        end
    end
end

# 初始化，以便在打开新 shell 时立即生效
__auto_source_venv

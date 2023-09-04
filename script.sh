#!/bin/bash
python3=$(python3 --version 2>&1 )
npm=$(npm -v 2>&1 )
os=$(uname)
GREEN='\033[0;32m'
RESET='\033[0m'
if echo "$python3" | grep -q "not found" || echo "$npm" | grep -q "not found" ; then
    if echo "$python3" | grep -q "not found" ; then
        if "$os" = "Darwin" ; then
            echo "Installing Homebrew,python,pip"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
            brew install python 
        else 
            echo "Installing Python and pip"
            sudo apt-get install python3
            sudo apt-get install python3-pip
        fi
    fi
    if echo "$npm" | grep -q "not found" ; then
        if "$os" = "Darwin" ; then
            echo "Installing Homebrew,node,npm"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
            brew install node
        else 
            echo "Installing Node and npm"
            sudo apt-get install nodejs npm
        fi
    fi
fi

# for node projects
if [ -e "package.json" ]; then 
    npm install 
fi

# for python projects
python_file=$( find . -type f -name "*.py"  )
if echo "$python_file" | grep -q ".py"  ; then
    pip install pipreqs || pip3 install pipreqs
    python3 -m pipreqs.pipreqs || python3 -m pipreqs
    python3 -m venv projectVenv
    sudo source projectVenv/bin/activate
    pip install -r requirements.txt || pip3 install -r requirements.txt
fi

echo -e "${GREEN}All the Dependencies are INSTALLED!!${RESET}"
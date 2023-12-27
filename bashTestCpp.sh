#!/bin/bash
checkMark="\xE2\x9C\x85"
crossMark="\xE2\x9D\x8C"
: '
    The main function is fn_studentsCppRun() if you want to test addition of two integer number
    fn_additionTest() allows you to do so. Just remember to undo the commented call of this function 
    in the main function. 
    fn_possibleCombinations() checks if the function you built was able to display all possible
    combinations of rolling two dice, the percentage of combined combinations that resulted in a number greater than 6
    , and the combinations that has the highest and smallest value.
'

fn_additionTest () {
    #values used for testing.
    local inputOneValues=("5" "10" "34" "100" "0" "1" "10" "31")
    local inputTwoValues=("6" "1" "20" "32" "4" "12" "32" "4")
    #expected results.
    local expectedResult=("11" "11" "54" "132" "4" "13" "42" "35")
    #number of passed tests
    local passedTest=0

    numTest=${#expectedResult[@]}
    for (( i=0 ; i < $numTest ; i++ ))
    do
        output=$(echo -e "${inputOneValues[$i]}\n${inputTwoValues[$i]}" | ./a.exe)

        if [[ "$output" -eq "${expectedResult[$i]}" ]]
        then
            echo -e "\nTest $i $checkMark: ${inputOneValues[$i]} + ${inputTwoValues[$i]} = $output"
            (( passedTest += 1 ))
        else
            echo -e "\nTest $i $crossMark: ${inputOneValues[$i]} + ${inputTwoValues[$i]} = $output"
        fi
    done
    
    echo -e "\n$checkMark: $passedTest\n$crossMark: $(( numTest - passedTest ))"
}

fn_possibleCombinations () {
    local output=$(./a.exe)
    local expectedValues=("1,1" "1,2" "1,3" "1,4" "1,5" "1,6" "2,1" "2,2" "2,3" "2,4" "2,5" "2,6" "3,1" "3,2" "3,3" "3,4" "3,5" "3,6" "4,1" "4,2" "4,3" "4,4" "4,5" "4,6" "5,1" "5,2" "5,3" "5,4" "5,5" "5,6" "6,1" "6,2" "6,3" "6,4" "6,5" "6,6" "58.3333%" "6,6" "1,1")
    local numTest=${#expectedValues[@]}
    local passedTest=0
    local i=0

    while read value
    do 
        Testvalue=$(echo "$value" | tr -d '\r')
        if [[ "$Testvalue" == "${expectedValues[$i]}" ]]
        then
            echo -e "Test $i $checkMark: ${expectedValues[$i]} == $Testvalue"
            (( passedTest += 1 ))
        else
            echo -e "Test $i $crossMark: ${expectedValues[$i]} != $Testvalue"
        fi
        (( i += 1 ))
    done <<< "$output"

    echo -e "\n$checkMark: $passedTest\n$crossMark: $(( numTest - passedTest ))"
}

fn_studentsCppRun () {
    #getting the files of extension .cpp
    local files=$(ls -f *cpp)

    #array of files
    local filesArr=()

    #Grading array
    local gradeArr=()

    #storing files in array
    while read -r file
    do
        filesArr+=("$file")
        gradeArr+=("0")
    done < <(echo "$files")

    local numStudent=${#filesArr[@]}
    for (( j=0 ; j < $numStudent ; j++))
    do 
        if [[ -a "./a.exe" ]]
        then
            rm ./a.exe
        fi
        gcc "./${filesArr[$j]}" -lstdc++
        
        echo -e "\n${filesArr[$j]}"
        echo "==========="
        
        #Test to run
        #additon test
        #fn_additionTest

        #Possible dice Combination test
        #fn_possibleCombinations

        #Deletion of compiled file
        rm ./a.exe
    done
}

fn_studentsCppRun
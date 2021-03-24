#!/bin/sh

helpFunc(){
    echo "smake usage:"
    echo "smake compile"
    echo "smake install DESTINATION INSTALLFILELIST"
    echo "smake clean"
    echo "smake help"
    return 0
}
otherFunc(){
    echo "smake usage:"
    echo "smake compile"
    echo "smake install DESTINATION INSTALLFILELIST"
    echo "smake clean"
    return 0
}
cleanFunc(){
    oFiles=$(find -maxdepth 1 -name "*.o" )
    `rm *.o >> /dev/null 2>&1`

    echo -n  "smake: Do you want to remove the binary file? (y/N)"
    read instr
    if [ ${instr} = "y" ]
    then
        echo -n "smake: Enter your binary file name:"
        read filename
        if [  -f ./${filename} ]
        then
            `rm ${filename}`
            echo "smake: All files have been removed."
        else 
            echo "smake: Please enter an existing filename!"
        fi
        return 0
    elif [ ${instr} = "N" ]
    then
        [ ${#oFiles} = 0 ]&& echo "smake: Nothing to be done here, exiting..."
        return 0
    else 
        echo "smake: Please answer y/N!"
        return 0
    fi

    return 0
}
compileFunc(){
    cFiles=$(find -maxdepth 1 -name "*.c" )
    # cFiles=$(ls *.c)
    # echo ${cFiles}
    if [ ${#cFiles} = 0 ]
    then 
        echo "Not Found c files"
        return 0
    fi 

    ###
    #there is my fail try to use dash to split string to array
    # TO be honest, it's really hard for a naive shell scripter to use dash

    ###
    # $(echo ${cFiles} | awk '{split($0,arr," ");for(i in arr) print arr[i] }')

    # filelist=(`echo ${cFiles} | tr ' ' ' '`)
    # echo ${filelist}
    # for file in   ${filelist[@]}
    # do 
    #     echo "123 ${file}"
    #     simpleName=$(echo ${file} | awk '{ string=substr($0,2,length($0)-4); print string; }')
    #      echo "gcc -c ${file} && gcc ${simpleName}.o -o ${simpleName}  "
    #     `gcc -c ${file} && gcc ${simpleName}.o -o ${simpleName}  >> /dev/null 2>&1`
    #     if [ $? -ne 0 ]
    #     then
    #         echo "smake: smake didn't sucessfully compile because some errors arose."
    #         return 1
    #     fi
    # done    
    # return 0
    index=1
    while :
    do 
        file=`echo ${cFiles}|cut -d " " -f ${index}`
        if [ "${file}" != "" ]
        then
                index=`expr ${index} + 1`
                simpleName=$(echo ${file} | awk '{ string=substr($0,3,length($0)-4); print string; }')
                #  echo "gcc -c ${file} && gcc ${simpleName}.o -o ${simpleName}  "
                `gcc -c ${file} && gcc ${simpleName}.o -o ${simpleName}  >> /dev/null 2>&1`
                if [ $? -ne 0 ]
                then
                    echo "smake: smake didn't sucessfully compile because some errors arose."
                    return 1
                fi
        else
            break
        fi
    done
    return 0
}   
installFunc(){

    
    if [ -d $2 ]
    then
        dir=$2
        shift
        shift
        while [ $# != 0 ]
        do
            
            if [ -f $1 ] 
            then 
                # echo $1
                cp $1 ${dir}
            else
                echo "smake: This Installfile doesn't exist!"
                return 0
            fi
            shift    
        done 
       
    else 
        echo "smake: Please use a valid destination!"
        return 0
    fi

    return 0
}

case "$1" in
"help")
    # echo "参数有$#个"
    helpFunc
    ;;
"clean")
    # echo "参数有$#个"
    if [ $# -eq 1 ]
    then
       cleanFunc
    else 
        otherFunc
    fi
    ;;
"compile")
    # echo "参数有$#个"
    if [ $# -eq 1 ]
    then
       compileFunc
    else 
        otherFunc
    fi
    ;;
"install")
    # echo "参数有$#个"
    if [ $# -ge 3 ]
    then
       installFunc $@
    else 
        otherFunc
    fi
    ;;
*)
    # echo "参数有$#个"
    otherFunc
    ;;
esac

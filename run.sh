#!/bin/bash
build_generator() 
{
    docker build -f Dockerfile.data_maker -t image_gen .
}

run_generator() 
{
    mkdir -p data
    docker run --rm -v "/$PWD/data:/data" image_gen
}

create_local_data() 
{
    mkdir -p local_data
    python generate.py local_data
}

build_reporter() 
{
    docker build -f Dockerfile.report_maker -t image_analitik .
}

run_reporter() 
{
    mkdir -p data
    docker run --rm -v "/$PWD/data:/data" image_analitik
}

structure() 
{
    find . 
}

clear_data() 
{
    rm -f data/*.csv
    rm -f data/*.html
}

inside_generator() 
{
    MSYS_NO_PATHCONV=1 docker run --rm -v "$(pwd)/data:/data" image_gen ls -la /data/
}

inside_reporter() 
{
    MSYS_NO_PATHCONV=1 docker run --rm -v "$(pwd)/data:/data" image_analitik ls -la /data/
}

case "$1" in
    build_generator)
        build_generator
        ;;
    run_generator)
        run_generator
        ;;
    create_local_data)
        create_local_data
        ;;
    build_reporter)
        build_reporter
        ;;
    run_reporter)
        run_reporter
        ;;
    structure)
        structure
        ;;
    clear_data)
        clear_data
        ;;
    inside_generator)
        inside_generator
        ;;
    inside_reporter)
        inside_reporter
        ;;
    *)
        echo "Ошибка: неизвестная команда"
        exit 1
        ;;
esac
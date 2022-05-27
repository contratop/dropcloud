@echo off
title "Server Analysis"
    cls
        echo "Comprobando servicios de %LOGONSERVER%"
            set machine=80.59.36.44
                    ping -n 1 %machine% > nul
                    if errorlevel 1 goto BAD
                    goto GOOD
                :GOOD
                    echo "Ping OK"

                    goto END
                :BAD
                    echo "Ping ERROR"
                :END
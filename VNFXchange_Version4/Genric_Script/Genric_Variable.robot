*** Variables ***
@{RedHat}         10.53.214.10    root    techm123
@{Server2}        172.18.0.1    root    root123
${Start_PcapTrace}    ${EMPTY}
${Stop_PcapTrace}    ${EMPTY}
${IXIA_Traffic_Cmd}    tclsh85 l2-l3.tcl>>log-IXIAexecution.txt
${Server}         ${EMPTY}

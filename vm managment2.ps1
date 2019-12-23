#Running this script will allow you to choose one Hyper-V vm and either turn it on, off or remove the vm.
<#
This is will display the VM's based on the name entered. It has wild cards before and after the name to pull everything related to the search. 
#>
function get_vm(){
$VMname = Read-Host('VM name')
$VM_Name = get-vm|Where-Object {$_.name -like '*' + $VMname + '*'}
    for($i=0 ; $i -le $VM_Name.length -1 ;$i++){
        write-host($i+1)($VM_Name.name[$i]) 'State:'($VM_Name.state[$i])}
        while(1 -eq 1){
        
            [int]$chosen_vm =(Read-host('what vm do you whish to change?'))
                if (-Not $chosen_vm ) {
                    Write-Host('You must select a Valid VM')
                    }                               
                else{ return $VM_Name.name[$chosen_vm]}
                                                }
}
#This function takes the choosen vm and gives the three options for alter the state of the vm or remove the vm. 
function vm_action([string]$get_vm)
{
while (1 -eq 1){
   $action = Read-Host('please choose an action:`
             1.Turn on VM`
             2.turn off vm`
             3.delete vm`
             :')
 
    if ($action -eq '1'){
        start-vm -name $get_vm;break}
        
    elseif($action -eq '2'){
        stop-vm -name $get_vm;break}
        
    elseif($action -eq '3'){
        remove-vm -name $get_vm;break}
    else{
        Write-Output('you must enter a correct action')}
        
        }

}
#This runs the funtions in order of get_vm then vm_action passing the choise to vm_action.
vm_action(get_vm)

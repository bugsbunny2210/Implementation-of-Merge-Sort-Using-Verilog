`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2022 23:15:40
// Design Name: 
// Module Name: mergesort
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2022 20:11:48
// Design Name: 
// Module Name: merge_sort
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module merge_sort_vsd(
output reg [31:0] op,input [31:0] data_bus,input clk,res
    );
    parameter N=16;
    parameter O=7;
    parameter a=3'b000,b=3'b001,c=3'b010,d=3'b011,e=3'b100,f=3'b101,g=3'b110,h=3'b111;
    parameter def_value=32'h7f7f_ffff;
    reg [31:0] rg_bank [0:O-1];
    reg [(32*N)-1:0] tempR;
    reg [2:0] state;
    integer count,ind,startA,startB,i,j,k,l,index,M;
    reg [31:0] temp,tempA;
    reg [7:0] word=8'b0000_0001;
    reg [31:0] reg_bank [0:N-1];
    always @(posedge clk)
        begin
            if(res)
                begin
                    state<=a;
                    M<=(O[0]==0)?O:(O+1);
                end
            else

        begin
            case(state)
                a: begin                   
                    count<=0; 
                    state<=b;
                    ind<=1;
                    i<=1;
                    k<=0;
                    l<=0;
                    j<=0; 
                    index<=N-M;
                  end
                b: begin
                        if(index<N)                           
                            begin
                                state<=b;
                                if(ind==1)
                                    begin
                                        tempA<=data_bus;
                                        ind<=2;
                                    end
                                 else if(ind==2 && ((index!=(N-2))||O[0]==0))
                                    begin
                                        if(tempA[31]==1'b0 && data_bus[31]==1'b0)
                                            begin
                                            if(tempA>data_bus)
                                                begin
                                             
                                                    reg_bank[index]<=data_bus;
                                                    reg_bank[index+1]<=tempA;
                                                    index<=index+2;
                                                    ind<=1;
                                                end 
                                            else
                                                begin
                                                
                                                    reg_bank[index]<=tempA;
                                                    reg_bank[index+1]<=data_bus;
                                                    index<=index+2;
                                                    ind<=1;
                                                end
                                         end
                                        else if(tempA[31]==1'b1 && data_bus[31]==1'b1)
                                            begin
                                            if(tempA<data_bus)
                                                begin
                                             
                                                    reg_bank[index]<=data_bus;
                                                    reg_bank[index+1]<=tempA;
                                                    index<=index+2;
                                                    ind<=1;
                                                end 
                                            else
                                                begin
                                                
                                                    reg_bank[index]<=tempA;
                                                    reg_bank[index+1]<=data_bus;
                                                    index<=index+2;
                                                    ind<=1;
                                                end
                                         end

                                        
                                        else if(tempA[31]==1'b0 && data_bus[31]==1'b1)
                                            begin
                                                    reg_bank[index]<=data_bus;
                                                    reg_bank[index+1]<=tempA;
                                                    index<=index+2;
                                                    ind<=1;                                         
                                            end

                                       else
                                            begin
                                                    reg_bank[index]<=tempA;
                                                    reg_bank[index+1]<=data_bus;
                                                    index<=index+2;
                                                    ind<=1;
                                            end
                                    end
                                else if(index==(N-2))
                                    begin
                                        reg_bank[index]=data_bus;
                                        reg_bank[index+1]=def_value;
                                        index<=index+2;
                                    end

                                                         
                            end
                        else
                            begin
                                count<=0;
                                state<=c;
                            end
                   end
               c:  begin   
                        count<=count+1;
                        startA<=0;
                        startB<=(word<<i);
                       
                        if(count==0)
                            begin
                                state<=c;
                            end
                        else
                            begin
                        if((startA+startB)<N) 
                            begin 
                               state<=d;
                               count<=0;
                            end 
                        else 
                            begin 
                                state<=g; 
                               count<=0;
                            end 
                           end
                   end 
               d:  begin
                        
                        if(count<(word<<(i+1)))
                            begin
                                count<=count+1;
                                if(l<(word<<i)&&j<(word<<i))
                                    begin
                                         if(reg_bank[startA+j][31]==1'b0 && reg_bank[startB+l][31]==1'b0)
                                            begin
                                                 if(reg_bank[startA+j]<=reg_bank[startB+l])
                                                    begin
                                                        tempR<={reg_bank[startA+j],tempR}>>32;
                                                        j<=j+1;
                                                    end
                                                 else if(reg_bank[startA+j]>reg_bank[startB+l])
                                                    begin
                                                        tempR<={reg_bank[startB+l],tempR}>>32;
                                                        l<=l+1;
                                                    end
                                            end
                                         else if(reg_bank[startA+j][31]==1'b1 && reg_bank[startB+l][31]==1'b1)
                                            begin
                                                 if(reg_bank[startA+j]>reg_bank[startB+l])
                                                    begin
                                                        tempR<={reg_bank[startA+j],tempR}>>32;
                                                        j<=j+1;
                                                    end
                                                 else if(reg_bank[startA+j]<=reg_bank[startB+l])
                                                    begin
                                                        tempR<={reg_bank[startB+l],tempR}>>32;
                                                        l<=l+1;
                                                    end
                                            end
                                        else if(reg_bank[startA+j][31]==1'b1 && reg_bank[startB+l][31]==1'b0)
                                            begin
                                                        tempR<={reg_bank[startA+j],tempR}>>32;
                                                        j<=j+1;
                                            end
                                        else if(reg_bank[startA+j][31]==1'b0 && reg_bank[startB+l][31]==1'b1)
                                            begin
                                                        tempR<={reg_bank[startB+l],tempR}>>32;
                                                        l<=l+1;
                                            end
    
                                    end
                                else
                                    begin
                                        if(l==(word<<i))
                                            begin
                                                 tempR<={reg_bank[startA+j],tempR}>>32;
                                                 j<=j+1;
                                                 state<=d;
                                            end
                                     
                                            
                                        else
                                            begin
                                                 tempR<={reg_bank[startB+l],tempR}>>32;
                                                 l<=l+1;
                                                 state<=d;
                                            end
                                    end
                             end
                         else
                            begin
                                state<=e;
                            end
                   end
                e: begin 
                        count<=0;
                        j<=0;
                        l<=0;
                        startA<=startA+(word<<(i+1));
                        startB<=startB+(word<<(i+1));
                        if(startA<N)
                            begin
                                state<=d;
                            end
                        else
                            begin
                                state<=f;
                                index<=0;
                            end  
                        end
               f: begin
                        index<=index+1;
                        if(index==0)
                            begin
                                state<=f;
                                {tempR,temp}<={tempR,temp}>>32;
                            end
                        else
                            begin
                                {tempR,temp}<={tempR,temp}>>32;
                                if(count<N)
                                    begin
                                        reg_bank[count]<=temp;
                                        count<=count+1;
                                        state<=f;
                                    end
                                else
                                    begin
                                        i<=i+1;
                                        state<=c;
                                        count<=0;
                                    end
                            end 
                  end
             g: begin
                       if(count<O)
                            begin
                                  rg_bank[count]<=reg_bank[count];  
                                  count<=count+1;
                                  state<=g;
                                 op<=reg_bank[count];
                            end
                       else
                            begin
                                state<=g;
                            end
                end


               default: begin   state<=g; end
            endcase
        end
    end
endmodule

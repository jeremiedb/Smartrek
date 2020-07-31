using Revise
using Smartrek

# In[0] XOR ((NOT In[1]) AND (In[2] XNOR In[3]))
# 1-Index: # In[1] XOR ((NOT In[2]) AND (In[3] XNOR In[4]))
function logic_A(x)
    out = x[1] ⊻ (!x[2] & (!x[3] ⊻ x[4]))
end

c_A = Circuit(4, logic_A)
A_result = Smartrek.sum_ans(c_A)
println("Circuit A results: ")
println("sum: \n", A_result.sum, "\n")
println("list: \n", A_result.list, "\n")

# raw: ((In[0] NAND (NOT (((In[1] XNOR In[2]) NOR (In[3] OR In[4])) NOR ((In[5] AND In[6]) NAND (In[7] NOR In[8]))))) AND (NOT In[9]))
# 1-Index: # ((In[1] NAND (NOT (((In[2] XNOR In[3]) NOR (In[4] OR In[5])) NOR ((In[6] AND In[7]) NAND (In[8] NOR In[9]))))) AND (NOT In[10]))
function logic_B(x::BitVector)
    return AND(NAND(x[1], NOT(NOR(NOR(XNOR(x[2], x[3]), OR(x[4], x[5])), NAND(AND(x[6], x[7]), NOR(x[8], x[9]))))), NOT(x[10]))
end

c_B = Circuit(10, logic_B)
B_result = Smartrek.sum_ans(c_B)
println("Circuit B results: ")
println("sum: \n", B_result.sum, "\n")
println("list: \n", B_result.list, "\n")

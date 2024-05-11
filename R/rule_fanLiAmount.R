
#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' rule_fanLiAmountServer()
rule_fanLiAmountServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  token=dms_token

  text_rule_fanLiAmount_delete=tsui::var_text('text_rule_fanLiAmount_FBillNo_delete')
  text_rule_fanLiAmount_FBillNo=tsui::var_text('text_rule_fanLiAmount_FBillNo')
  text_rule_fanLiAmount_FCustomerName=tsui::var_text('text_rule_fanLiAmount_FCustomerName')
  text_rule_fanLiAmount_FIndexType=tsui::var_text('text_rule_fanLiAmount_FIndexType')
  text_rule_fanLiAmount_FStartRealAmount=tsui::var_text('text_rule_fanLiAmount_FStartRealAmount')

  text_rule_fanLiAmount_FEndRealAmount=tsui::var_text('text_rule_fanLiAmount_FEndRealAmount')
  text_rule_fanLiAmount_FUnit=tsui::var_text('text_rule_fanLiAmount_FUnit')
  text_rule_fanLiAmount_FRebateRate=tsui::var_text('text_rule_fanLiAmount_FRebateRate')
  text_rule_fanLiAmount_FEffectDate=tsui::var_date('text_rule_fanLiAmount_FEffectDate')

  text_rule_fanLiAmount_FExpireDate=tsui::var_date('text_rule_fanLiAmount_FExpireDate')


  #查询
  shiny::observeEvent(input$btn_rule_fanLiAmount_view,{
    data=mdlGrossProfitAnalysisPkg::rule_fanLiAmount_view(token=dms_token)
    tsui::run_dataTable2(id = 'rule_fanLiAmount_resultView',data=data)

  })
  #添加
  shiny::observeEvent(input$btn_rule_fanLiAmount_add,{
    FBillNo = text_rule_fanLiAmount_FBillNo()
    FCustomerName = text_rule_fanLiAmount_FCustomerName()
    FIndexType =text_rule_fanLiAmount_FIndexType()
    FStartRealAmount = text_rule_fanLiAmount_FStartRealAmount()
    FEndRealAmount = text_rule_fanLiAmount_FEndRealAmount()
    FUnit = text_rule_fanLiAmount_FUnit()
    FRebateRate = text_rule_fanLiAmount_FRebateRate()
    FEffectDate = text_rule_fanLiAmount_FEffectDate()
    FExpireDate = text_rule_fanLiAmount_FExpireDate()
    mdlGrossProfitAnalysisPkg::rule_fanLiAmount_add(token=dms_token,FBillNo =FBillNo ,FCustomerName =FCustomerName ,FIndexType = FIndexType,FStartRealAmount = FStartRealAmount,FEndRealAmount =FEndRealAmount ,FUnit = FUnit,FRebateRate =FRebateRate ,FEffectDate =FEffectDate ,FExpireDate = FExpireDate)
    tsui::pop_notice('添加完成')
  })

  #删除
  shiny::observeEvent(input$btn_rule_fanLiAmount_delete,{
    FBillNo = text_rule_fanLiAmount_delete()

    mdlGrossProfitAnalysisPkg::rule_fanLiAmount_delete(token=dms_token,FBillNo =FBillNo )
    tsui::pop_notice('删除完成')
  })

}

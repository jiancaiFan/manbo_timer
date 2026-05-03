@ComponentV2
export struct FormInputRow {
  @Param label: string = "";
  @Param placeholder: string = "";
  @Param value: string = "";
  @Event valueChange: (val: string) => void = () => {
  };
  @Param inputType: InputType = InputType.Normal;

  build() {
    Row() {
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Bolder)
        .fontColor('#1D1D1F')

      TextInput({ placeholder: this.placeholder, text: this.value })
        .type(this.inputType)
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1D1D1F')
        .placeholderColor('rgba(0,0,0,0.2)')
        .placeholderFont({ weight: FontWeight.Bold })
        .textAlign(TextAlign.End)
        .backgroundColor(Color.Transparent)
        .width('60%')
        .onChange((val: string) => this.valueChange(val))
    }
    .width('100%')
    .height(56)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .borderRadius(16)
    .padding({ left: 16, right: 16 })
    .border({ width: 1, color: 'rgba(0,0,0,0.03)' })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}
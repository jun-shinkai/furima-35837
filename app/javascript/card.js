const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
 const form = document.getElementById("charge-orm");
 form.addEventListener("submit",(e) => {
   e.preventDefault();

 const formResult = document.getElementById("charge-orm");
 const formData   = new FormData(formResult);

 const card = {
  number: formData.get("number"),
  cvc: formData.get("cvc"),
  exp_month: formData.get("exp_month"),
  exp_year: `20${formData.get("exp_year")}`,
   };

   Payjp.createToken(card, (status, response) => {
    if (status == 200){
      const token = response.id;
      const renderDom = document.getElementById("charge-orm")
      const tokenObj = `<input value=${token} type="hidden" name = 'card_token'>`;
      renderDom.insertAdjacentHTML("beforeend",tokenObj);
    }

    document.getElementById("card-number").removeAttribute("name")
    document.getElementById("card-exp-month").removeAttribute("name")
    document.getElementById("card-exp-year").removeAttribute("name")
    document.getElementById("card-cvc").removeAttribute("name")

     document.getElementById("charge-orm").submit();
   })
 })
}

window.addEventListener("load", pay);
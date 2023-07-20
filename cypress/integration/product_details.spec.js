describe("product detail page", () => {

  it("can navigate to the product detail page by clicking on a product on the home page", () => {
    cy.visit("/")
    cy.get(".products article").should("be.visible")
    cy.get(".products article").should("have.length", 2)
    cy.get(".products article").first().click()
    cy.get("article.product-detail").should("exist")

  })
  
})
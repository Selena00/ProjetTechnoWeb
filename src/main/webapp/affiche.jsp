<%-- 
    Document   : affiche
    Created on : 2 avr. 2019, 14:06:27
    Author     : infoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- On charge jQuery -->
        <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <!-- On charge le moteur de template mustache https://mustache.github.io/ -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>
        <link rel="stylesheet" type="text/css" href="java3.css">
        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
        <script>
        $(document).ready(// Exécuté à la fin du chargement de la page
                    function () {
                        // On montre la liste des codes
                        showCommandes();
                    }
            );
    
        function showCommandes() {
                // On fait un appel AJAX pour chercher les codes
                $.ajax({
                    url: "allCommandes",
                    dataType: "json",
                    error: showError,
                    success: // La fonction qui traite les résultats
                            function (result) {
                                // Le code source du template est dans la page
                                var template = $('#commandesTemplate').html();
                                // On combine le template avec le résultat de la requête
                                var processedTemplate = Mustache.to_html(template, result);
                                // On affiche la liste des options dans le select
                                $('#commandes').html(processedTemplate);
                            }
                });
            }
            
            // Supprimer un code
            function deleteCommande(ordernum) {
                $.ajax({
                    url: "deleteCommande",
                    data: {"ordernum": ordernum},
                    dataType: "json",
                    success: 
                            function (result) {
                                showCommandes();
                                console.log(result);
                            },
                    error: showError
                });
                return false;
            }
        
        
        </script>
        <title>JSP Page</title>
    </head>
    <STYLE>A {text-decoration: none; color: black;} </STYLE>
    <body>
        <nav class="barAffiche">
            <ol>
                <li class="a2"><a href="index.html">Accueil</a>  </li>
                <li class="a2"><a href=""> Votre compte </a> </li>
                <li class="a2"><a href="">Déconnexion</a>  </li>
            </ol>
        </nav>
        
        <h1>Edition des commandes</h1>
         <!-- La zone où les résultats vont s'afficher -->
        <div id="commandes"></div>
        
        <a href="#">Ajouter une commande</a>
        
        <!-- Le template qui sert à formatter la liste des codes -->
        <script id="commandesTemplate" type="text/template">
            <TABLE>
            <tr><th>Numéro de commande</th><th>ID Client</th><th>ID Produit</th><th>Quantité</th><th>Prix de livraison</th><th>Date de Vente</th><th>Date de Livraison</th><th>Companie de livraison</th><th>modifier</th><th>supprimer</th></tr>
            {{! Pour chaque enregistrement }}
            {{#records}}
                {{! Une ligne dans la table }}
                <TR><TD>{{ordernum}}</TD><TD>{{idcustomer}}</TD><TD>{{idproduct}}</TD><TD>{{quantity}}</TD><TD>{{shippingcost}}</TD><TD>{{salesDate}}</TD><TD>{{shippingDate}}</TD><TD>{{company}}</TD><TD><button><a href="">Modifier</a></button></TD><TD><button onclick="deleteCommande('{{ordernum}}')">Supprimer</button></TD></TR>
            {{/records}}
            </TABLE>
        </script>
        
        
    </body>

</html>
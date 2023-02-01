param($data)

function CustomCard {
    Param (
        $ImageSrc
    )

    Div -Class 'cell-lg-4' -Content {
        Div -Class 'price-item text-center bg-white win-shadow' -Content {
            Div -Class 'price-item-header p-6' -Content {
                Div -Class 'img-container rounded' -Content {
                    img -src $($ImageSrc)
                    Div -Class 'image-overlay op-green' 
                }
            }
        }
    }
}
return html -Content {
    head -Content {
        Title -Content "CoC | Index"
        Link -href "https://cdn.metroui.org.ua/v4.3.2/css/metro-all.min.css" -rel "stylesheet"
        script -src "https://cdn.metroui.org.ua/v4/js/metro.min.js"
    }
    body -Content {
        (1..3).ForEach({ br })
        Div -Class 'container' -Content {
            h3 -Class 'Secondary fg-lightBlue' -Content 'Colors of Cuisine...' -Style 'text-align:center'
            hr
            Div -Class 'row flex-align-center rounded' -Content {
                @(
                    "https://media.istockphoto.com/photos/dabba-masala-picture-id465015726?b=1&k=20&m=465015726&s=170667a&w=0&h=IsNYymgb7aX2qZcZ-IdBVZ7xC1m6JNJ9ZFOcEvF_PiM=",
                    "https://media.istockphoto.com/photos/idly-or-idli-picture-id1306083224?b=1&k=20&m=1306083224&s=170667a&w=0&h=USIy9AUuJVA2dboZOHdAc8EUl_1QHWbivvRJUEYQfWk=",
                    "https://media.istockphoto.com/photos/frying-egg-in-a-cooking-pan-in-domestic-kitchen-picture-id1129381764?b=1&k=20&m=1129381764&s=170667a&w=0&h=P3Gw15Zps0Mu_NF7wNwVkfpVqGV3LC7Pg1YbZXBMcnc="
                ).ForEach(
                    {
                        CustomCard -ImageSrc $($_)  
                    }
                )
            }
            hr 
        }
    }
}
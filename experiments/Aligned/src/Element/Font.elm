module Element.Font
    exposing
        ( alignLeft
        , alignRight
        , bold
        , center
        , color
        , family
          -- , importUrl
        , glow
        , italic
        , justify
        , justifyAll
        , letterSpacing
        , light
        , lineHeight
        , monospace
        , sansSerif
        , serif
        , shadow
        , size
        , strike
        , typeface
        , underline
        , weight
        , wordSpacing
        )

{-| Font Properties

Meant to be imported as:

    import Style.Font as Font


## Typefaces

@docs color, typeface, font, serif, sansSerif, cursive, fantasy, monospace, importUrl


## Properties

@docs size, lineHeight, letterSpacing, wordSpacing, alignLeft, alignRight, center, justify, justifyAll


## Font Styles

@docs underline, strike, italic, bold, weight, light

-}

import Color exposing (Color)
import Internal.Model as Internal exposing (Attr(..), Attribute, Style(..))


type Font
    = Serif
    | SansSerif
    | Monospace
    | Typeface String
    | ImportFont String String



-- {-| Text decoration color.
-- -}
-- decoration : Color -> Property
-- decoration clr =
--     Internal.Exact "text-decoration-color" (formatColor clr)
-- {-| -}
-- selection : Color -> Property
-- selection clr =
--     Internal.SelectionColor clr


{-| -}
color : Color -> Attribute msg
color clr =
    StyleClass (Colored ("text-color-" ++ Internal.formatColorClass clr) "color" clr)


{-| -}
family : List Font -> Attribute msg
family families =
    let
        renderedFonts =
            let
                renderFont font =
                    case font of
                        Serif ->
                            "serif"

                        SansSerif ->
                            "sans-serif"

                        Monospace ->
                            "monospace"

                        Typeface name ->
                            "\"" ++ name ++ "\""

                        ImportFont name url ->
                            "\"" ++ name ++ "\""
            in
            families
                |> List.map renderFont
                |> String.join ", "
    in
    StyleClass <|
        Single ("font-" ++ Internal.className renderedFonts) "font-family" renderedFonts


{-| -}
serif : Font
serif =
    Serif


{-| -}
sansSerif : Font
sansSerif =
    SansSerif


{-| -}
monospace : Font
monospace =
    Monospace


{-| -}
typeface : String -> Font
typeface =
    Typeface



-- {-| -}
-- importUrl : { url : String, name : String } -> Font
-- importUrl { url, name } =
--     Internal.ImportFont name url


{-| Font size as `px`
-}
size : Int -> Attribute msg
size size =
    StyleClass (Single ("font-size-" ++ toString size) "font-size" (toString size ++ "px"))


{-| This is the only unitless value in the library that isn't `px`.

Given as a _proportion_ of the `Font.size`.

This means the final lineHeight in px is:

      Font.size * Font.lineHeight == lineHeightInPx

-}
lineHeight : Float -> Attribute msg
lineHeight height =
    StyleClass (Single ("line-height-" ++ Internal.floatClass height) "line-height" (toString height))


{-| In `px`.
-}
letterSpacing : Float -> Attribute msg
letterSpacing offset =
    StyleClass <|
        Single
            ("letter-spacing-" ++ Internal.floatClass offset)
            "letter-spacing"
            (toString offset ++ "px")


{-| In `px`.
-}
wordSpacing : Float -> Attribute msg
wordSpacing offset =
    StyleClass <|
        Single ("word-spacing-" ++ Internal.floatClass offset) "word-spacing" (toString offset ++ "px")


{-| -}
weight : Int -> Attribute msg
weight fontWeight =
    StyleClass <|
        Single ("font-weight-" ++ toString fontWeight) "word-spacing" (toString fontWeight ++ "px")


{-| Align the font to the left.
-}
alignLeft : Attribute msg
alignLeft =
    Internal.class "text-left"


{-| Align the font to the right.
-}
alignRight : Attribute msg
alignRight =
    Internal.class "text-right"


{-| Align font center.
-}
center : Attribute msg
center =
    Internal.class "text-center"


{-| -}
justify : Attribute msg
justify =
    Internal.class "text-justify"


{-| -}
justifyAll : Attribute msg
justifyAll =
    Internal.class "text-justify-all"


{-| -}
underline : Attribute msg
underline =
    Internal.class "underline"


{-| -}
strike : Attribute msg
strike =
    Internal.class "strike"


{-| -}
italic : Attribute msg
italic =
    Internal.class "italic"


{-| -}
bold : Attribute msg
bold =
    Internal.class "bold"


{-| -}
light : Attribute msg
light =
    Internal.class "text-light"


{-| -}
shadow :
    { offset : ( Float, Float )
    , blur : Float
    , color : Color
    }
    -> Internal.Attribute msg
shadow { offset, blur, color } =
    Internal.TextShadow
        { offset = offset
        , blur = blur
        , color = color
        }


{-| -}
glow : Color -> Float -> Internal.Attribute msg
glow color size =
    Internal.TextShadow
        { offset = ( 0, 0 )
        , blur = size * 2
        , color = color
        }
module Example.Site where

import Prelude
import Data.Argonaut (class DecodeJson, class EncodeJson, Json, gDecodeJson, gEncodeJson)
import Data.Generic (class Generic, gShow)
import Hyper.Routing (type (:/), type (:<|>), type (:>), Capture)
import Hyper.Routing.Method (Get)
import Type.Proxy (Proxy(..))

type TaskId = Int

data Task = Task TaskId String

derive instance genericTask :: Generic Task

instance showTask :: Show Task where show = gShow
instance encodeJsonTask :: EncodeJson Task where encodeJson = gEncodeJson
instance decodeJsonTask :: DecodeJson Task where decodeJson = gDecodeJson

type Site =
  "tasks" :/ (Get Json (Array Task)
              :<|> Capture "id" TaskId :> Get Json Task)

site :: Proxy Site
site = Proxy
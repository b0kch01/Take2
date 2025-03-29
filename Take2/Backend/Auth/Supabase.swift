//
//  Supabase.swift
//  Take2
//
//  Created by Nathan Choi on 3/28/25.
//

import Foundation
import Supabase

let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://dgrtwguzloplsmbvcpkn.supabase.co")!,
  supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRncnR3Z3V6bG9wbHNtYnZjcGtuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMwNTc5MTksImV4cCI6MjA1ODYzMzkxOX0.mB0T7lQ2I3BH9PUfBcwNdigBSV19ETBfhwNwW0m_RVM"
)
